import { createHandler, type DeletionGateway } from "./handler.ts";

const good: DeletionGateway = {
  verifyUser: () => Promise.resolve(true),
  requestDeletion: () => Promise.resolve("receipt"),
};
function request(method = "POST", token = "Bearer test-token") {
  return new Request("http://localhost/request-deletion", {
    method,
    headers: { Authorization: token },
  });
}
for (
  const [name, req, expected] of [
    ["reject GET", request("GET"), 405],
    ["reject missing bearer", request("POST", ""), 401],
    ["reject empty bearer", request("POST", "Bearer "), 401],
    ["accept verified actor", request(), 202],
  ] as const
) {
  Deno.test(name, async () => {
    const response = await createHandler(good)(req);
    if (response.status !== expected) throw new Error(`Expected ${expected}`);
  });
}
Deno.test("invalid session never reaches database", async () => {
  const response = await createHandler({
    verifyUser: () => Promise.resolve(false),
    requestDeletion: () => {
      throw new Error("Must not run");
    },
  })(request());
  if (response.status !== 401) throw new Error("Unauthorized");
});
Deno.test("reject request bodies even without a content-length header", async () => {
  const response = await createHandler(good)(
    new Request(
      "http://localhost/request-deletion",
      { method: "POST", headers: { Authorization: "Bearer test-token" }, body: "{}" },
    ),
  );
  if (response.status !== 400) throw new Error("Body must be rejected");
});
Deno.test("backend errors are sanitized", async () => {
  const response = await createHandler({
    ...good,
    requestDeletion: () => {
      throw new Error("secret policy details");
    },
  })(request());
  if (response.status !== 503 || (await response.text()).includes("secret")) {
    throw new Error("Unsafe error");
  }
});
Deno.test("receipt does not claim deletion completed", async () => {
  const body = await (await createHandler(good)(request())).json();
  if (body.deletion_completed !== false || body.status !== "requested") {
    throw new Error("Invalid contract");
  }
});
