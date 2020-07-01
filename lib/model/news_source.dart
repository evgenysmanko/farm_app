class NewsSource{
  final int id;
  final String title;
  final String imgUrl;
  final String rss;

  NewsSource(this.id, this.title, this.imgUrl, this.rss);

  factory NewsSource.fromJson(Map<String, dynamic> json){
    return NewsSource(json['id'], json['title'], json['imgUrl'], json['rss']);
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'imgUrl' : imgUrl,
    'rss' : rss
  };
}