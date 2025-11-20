class ApiEndpoints {
  // static String baseUrl = "http://192.168.0.108:4300/api";
  static String baseUrl = "http://10.25.130.28:4300/api";

  // Auth
  static String registerUrl = "$baseUrl/users/register";
  static String loginUrl = "$baseUrl/users/login";
  static String resetPassword = "$baseUrl/users/reset-password";
  static String checkOtp = "$baseUrl/users/check-otp";
  static String updateUserDetails = "$baseUrl/users/update/:id";

  //Area groups
  static String areaGroupsUrl = "$baseUrl/area-groups";
  static String areaGroupsDetailsUrl = "$baseUrl/area-groups/:id"; //get,put,del

  // Join request
  static String joinGroupUrl = "$areaGroupsUrl/join";
  static String getJoinRequestUrl = "$joinGroupUrl/:id";
  static String updateJoinReqUrl = "$joinGroupUrl/update";
  static String bulkAcceptJoinReqUrl = "$joinGroupUrl/accept/:reviewerId";
  static String bulkRejectJoinReqUrl = "$joinGroupUrl/reject/:reviewerId";

  // group members
  static String groupMembersUrl = "$areaGroupsUrl/member/:areaGroupId";
  static String groupsOfMembersUrl = "$areaGroupsUrl/member/group/:userId";
  static String noGroupsOfMembersUrl =
      "$areaGroupsUrl/member/group/not/:userId";
  static String promoteMemberToAdminUrl =
      "$areaGroupsUrl/member/:userId/promote-to-admin";
  static String demoteMemberToAdminUrl = "$areaGroupsUrl/member/:userId/demote";

  // connection
  static String requestConnectionUrl = "$baseUrl/contact/request-connection";
  static String getRequestOfUserUrl = "$baseUrl/contact/request/user/:id";
  static String getRequestReceivedToUserUrl =
      "$baseUrl/contact/request/received/:id";
  static String listConnectionsOfUser = "$baseUrl/contact/connection/:id";
  static String approveConnectionRequestUrl =
      "$baseUrl/contact/approve/:requestId";
  static String rejectConnectionRequestUrl =
      "$baseUrl/contact/reject/:requestId";
  static String deleteRequestUrl = "$baseUrl/contact/request";

  // post
  static String createPostUrl = "$baseUrl/post/create";
  static String likePostUrl = "$baseUrl/post/like/:id";
  static String getPostByIdUrl = "$baseUrl/post/:id";
  static String getPostsOfUserUrl = "$baseUrl/post/user/:id";
  static String getPostOfGroupUrl = "$baseUrl/post/group/:id";
  static String getFeedPostsUrl = "$baseUrl/feed/:id";

  //comment
  static String createCommentUrl = "$baseUrl/post/comment";
  static String getCommentsOfPostUrl = "$baseUrl/post/comment/:id";
  static String getCommentRepliesUrl = "$baseUrl/post/comment/replies/:id";

  //event
  static String getAllEventsUrl = "$baseUrl/event";
  static String createEventUrl = "$baseUrl/event/create";
  static String getEventByIdUrl = "$baseUrl/event/:id";
  static String getEventsByGroupIdUrl = "$baseUrl/event/group/:id";
  static String registerForEventUrl = "$baseUrl/event/register";
  static String getTicketsByUserIdUrl = "$baseUrl/event/ticket/user/:id";
  static String getTicketDetailsUrl = "$baseUrl/event/ticket/:id";

  //ads
  static String createAdsUrl = "$baseUrl/ads";
  static String getAdsUrl = "$baseUrl/ads/active";
  static String updateAdsUrl = "$baseUrl/ads/update/:id";

  // Bishi Apis
  static String createBishiGroupUrl = "$baseUrl/bishi/group/create";
  static String getBishiGroupsByAreaUrl = "$baseUrl/bishi/group/:id";
  static String getBishiByIdUrl = "$baseUrl/bishi/:id";
  static String getBishiGroupByUserUrl = "$baseUrl/bishi/user/:id";
  static String bishiJoinUrl = "$baseUrl/bishi/member/join";
  static String getBishiMembersUrl = "$baseUrl/bishi/members/:id";
  static String leaveBishiGroupUrl = "$baseUrl/bishi/members/leave/:id";

  // payment api
  static String getBishiPaymentUrl = "$baseUrl/bishi/member/payment/:id";
  static String updateBishiPaymentUrl = "$baseUrl/bishi/payment/update/:id";
}
