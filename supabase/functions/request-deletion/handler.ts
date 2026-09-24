export interface DeletionGateway {
  verifyUser(token: string): Promise<boolean>;
  requestDeletion(token: string): Promise<string>;
}

export function createHandler(gateway: DeletionGateway) {
  return async (request: Request): Promise<Response> => {
    const headers = {
      "Content-Type": "application/json",
      "Cache-Control": "no-store",
      "X-Content-Type-Options": "nosniff",
    };
    const reply = (status: number, body: object) =>
      new Response(JSON.stringify(body), { status, headers });
    if (request.method !== "POST") return reply(405, { error: "method_not_allowed" });
    const authorization = request.headers.get("Authorization");
    if (!authorization?.startsWith("Bearer ") || authorization.length <= 7) {
      return reply(401, { error: "authentication_required" });
    }
    // There is no target-user input: the verified JWT determines the actor.
    if (request.body !== null) {
      return reply(400, { error: "body_not_supported" });
    }
    try {
      if (!await gateway.verifyUser(authorization.slice(7))) {
        return reply(401, { error: "session_invalid" });
      }
      const receipt = await gateway.requestDeletion(authorization.slice(7));
      return reply(202, { request_id: receipt, status: "requested", deletion_completed: false });
    } catch {
      return reply(503, { error: "request_unavailable", correlation_id: crypto.randomUUID() });
    }
  };
}
