import 'package:flutter_test/flutter_test.dart';
import 'package:ggs_mobile/demo/demo_repositories.dart';
import 'package:ggs_mobile/demo/demo_store.dart';
import 'package:ggs_mobile/features/contact/domain/contact_models.dart';

void main() {
  late DemoStore store;

  setUp(() {
    store = DemoStore.instance;
    store.reset();
  });

  test(
    'Demo parity: Contact outreach repository full workflow verification',
    () async {
      final contactRepo = DemoContactOutreachRepository(store);

      // 1. Send Request from Agency to Creator
      final req = await contactRepo.sendContactRequest(
        senderUserId: 'demo_agency_user_id',
        senderOrganizationId: 'demo_agency_org_id',
        senderOrganizationName: 'Pulse Talent Agency',
        recipientCreatorId: 'demo_creator_user_id',
        recipientDisplayName: 'Priya Mehra',
        isRegisteredCreator: true,
        requestType: ContactRequestType.requestQuotation,
        campaignName: 'New Campaign',
        collaborationRequirement: 'Need 1 reel for summer launch',
      );

      expect(req.status, ContactRequestStatus.pending);
      expect(store.contactRequests.containsKey(req.id), isTrue);

      // 2. Creator checks incoming requests
      final incoming = await contactRepo.listCreatorIncomingRequests(
        creatorId: 'demo_creator_user_id',
      );
      expect(incoming.any((r) => r.id == req.id), isTrue);

      // 3. Creator submits private quotation
      final quote = await contactRepo.submitPrivateQuotation(
        requestId: req.id,
        creatorId: 'demo_creator_user_id',
        proposedAmount: 50000,
        deliverableDescription: '1 Dedicated Reel (60s)',
        usageRights: 'Digital Organic',
      );
      expect(quote.proposedAmount, 50000);
      expect(store.privateQuotations[req.id]?.proposedAmount, 50000);

      // 4. Creator accepts contact request
      final acceptedReq = await contactRepo.acceptContactRequest(
        requestId: req.id,
        creatorUserId: 'demo_creator_user_id',
      );
      expect(acceptedReq.status, ContactRequestStatus.accepted);
      final convId = acceptedReq.conversationId;
      expect(convId, isNotNull);
      expect(store.outreachConversations.containsKey(convId!), isTrue);

      // 5. Exchanging messages in outreach chat
      final msg = await contactRepo.sendMessage(
        conversationId: convId,
        senderId: 'demo_agency_user_id',
        senderName: 'Pulse Talent Agency',
        content: 'Glad to connect Priya!',
      );
      expect(msg.content, 'Glad to connect Priya!');

      final messages = await contactRepo.getMessages(convId);
      expect(
        messages.any((m) => m.content == 'Glad to connect Priya!'),
        isTrue,
      );

      // 6. Agency checks sent requests and quotation
      final sent = await contactRepo.listSentOutreach(
        userId: 'demo_agency_user_id',
      );
      expect(sent.any((r) => r.id == req.id), isTrue);

      final fetchedQuote = await contactRepo.getPrivateQuotation(req.id);
      expect(fetchedQuote?.proposedAmount, 50000);
    },
  );
}
