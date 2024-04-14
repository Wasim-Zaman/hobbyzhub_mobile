class Post {
  String? postId;
  String? userId;
  String? caption;
  List<String>? imageUrls;
  String? postTime;
  Set<Like>? likes;
  Set<Comment>? comments;
  bool? status;
  List<HashTag>? hashTags;
  String? username;
  String? profileImage;
  int? likeCount;
  bool? deActivateComments;

  Post({
    this.postId,
    this.userId,
    this.caption,
    this.imageUrls,
    this.postTime,
    this.likes,
    this.comments,
    this.status,
    this.hashTags,
    this.username,
    this.profileImage,
    this.likeCount,
    this.deActivateComments,
  });

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    userId = json['userId'];
    caption = json['caption'];
    imageUrls = json['imageUrls'].cast<String>();
    postTime = json['postTime'];
    status = json['status'];
    username = json['username'];
    profileImage = json['profileImage'];
    likeCount = json['likeCount'];
    deActivateComments = json['deActivateComments'];
    if (json['hashTags'] != null) {
      hashTags = (json['hashTags'] as List)
          .map((v) => HashTag.fromJson(v as Map<String, dynamic>))
          .toList();
    }
    if (json['likes'] != null) {
      likes = (json['likes'] as List)
          .map((v) => Like.fromJson(v as Map<String, dynamic>))
          .toSet();
    }
    if (json['comments'] != null) {
      comments = (json['comments'] as List)
          .map((v) => Comment.fromJson(v as Map<String, dynamic>))
          .toSet();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['userId'] = userId;
    data['caption'] = caption;
    data['imageUrls'] = imageUrls;
    data['postTime'] = postTime;
    data['status'] = status;
    data['username'] = username;
    data['profileImage'] = profileImage;
    data['likeCount'] = likeCount;
    data['deActivateComments'] = deActivateComments;
    if (hashTags != null) {
      data['hashTags'] = hashTags!.map((v) => v.toJson()).toList();
    }
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  String? commentId;
  int? commentCount;
  Post? postComment;
  String? message;
  Like? like;
  String? username;
  String? profileImage;
  String? commentTime;
  bool? deActivateComments;

  Comment({
    this.commentId,
    this.commentCount,
    this.postComment,
    this.message,
    this.like,
    this.username,
    this.profileImage,
    this.commentTime,
    this.deActivateComments,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    commentCount = json['commentCount'];
    message = json['message'];
    username = json['username'];
    profileImage = json['profileImage'];
    commentTime = json['commentTime'];
    deActivateComments = json['deActivateComments'];
    if (json['postComment'] != null) {
      postComment = Post.fromJson(json['postComment']);
    }
    if (json['like'] != null) {
      like = Like.fromJson(json['like']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commentId'] = commentId;
    data['commentCount'] = commentCount;
    data['message'] = message;
    data['username'] = username;
    data['profileImage'] = profileImage;
    data['commentTime'] = commentTime;
    data['deActivateComments'] = deActivateComments;
    if (postComment != null) {
      data['postComment'] = postComment!.toJson();
    }
    if (like != null) {
      data['like'] = like!.toJson();
    }
    return data;
  }
}

class Like {
  String? likeId;
  String? username;
  int? likeCount;
  Post? postLike;
  Comment? comment;
  String? profileImage;
  String? likeTime;
  String? userId;

  Like({
    this.likeId,
    this.username,
    this.likeCount,
    this.postLike,
    this.comment,
    this.profileImage,
    this.likeTime,
    this.userId,
  });

  Like.fromJson(Map<String, dynamic> json) {
    likeId = json['likeId'];
    username = json['username'];
    likeCount = json['likeCount'];
    profileImage = json['profileImage'];
    likeTime = json['likeTime'];
    userId = json['userId'];
    if (json['postLike'] != null) {
      postLike = Post.fromJson(json['postLike']);
    }
    if (json['comment'] != null) {
      comment = Comment.fromJson(json['comment']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['likeId'] = likeId;
    data['username'] = username;
    data['likeCount'] = likeCount;
    data['profileImage'] = profileImage;
    data['likeTime'] = likeTime;
    data['userId'] = userId;
    if (postLike != null) {
      data['postLike'] = postLike!.toJson();
    }
    if (comment != null) {
      data['comment'] = comment!.toJson();
    }
    return data;
  }
}

class HashTag {
  String? hashTagId;
  String? tagName;
  Set<Post>? posts;

  HashTag({
    this.hashTagId,
    this.tagName,
    this.posts,
  });

  HashTag.fromJson(Map<String, dynamic> json) {
    hashTagId = json['hashTagId'];
    tagName = json['tagName'];
    // if (json['posts'] != null) {
    //   posts = (json['posts'] as List)
    //       .map((v) => Post.fromJson(v as Map<String, dynamic>))
    //       .toSet();
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hashTagId'] = hashTagId;
    data['tagName'] = tagName;
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
