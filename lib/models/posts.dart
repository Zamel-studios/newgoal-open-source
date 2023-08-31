class PostData {
  String? postId;
  String? userId;
  String? postImg;
  String? postDescription;
  String? postDate;
  String? postField;
  String? sharedTask;

  PostData(
      {this.postId,
      this.userId,
      this.postImg,
      this.postDescription,
      this.postDate,
      this.postField,
      this.sharedTask});

  PostData.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    userId = json['user_id'];
    postImg = json['post_img'];
    postDescription = json['post_description'];
    postDate = json['post_date'];
    postField = json['post_field'];
    sharedTask = json['shared_task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['user_id'] = this.userId;
    data['post_img'] = this.postImg;
    data['post_description'] = this.postDescription;
    data['post_date'] = this.postDate;
    data['post_field'] = this.postField;
    data['shared_task'] = this.sharedTask;
    return data;
  }
}