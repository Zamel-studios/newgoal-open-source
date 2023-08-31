class CommentsModel {
  String? commentId;
  String? commenterId;
  String? commentDescription;
  String? commentDate;
  String? postId;

  CommentsModel(
      {this.commentId,
      this.commenterId,
      this.commentDescription,
      this.commentDate,
      this.postId});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    commentId = json['comment_id'];
    commenterId = json['commenter_id'];
    commentDescription = json['comment_description'];
    commentDate = json['comment_date'];
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment_id'] = this.commentId;
    data['commenter_id'] = this.commenterId;
    data['comment_description'] = this.commentDescription;
    data['comment_date'] = this.commentDate;
    data['post_id'] = this.postId;
    return data;
  }
}