class Ad {
  final String imageUrl;
  final String linkUrl;
  final String displayDuration;
  final int transitionTime;

  Ad({
    required this.imageUrl,
    required this.linkUrl,
    required this.displayDuration,
    required this.transitionTime,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      imageUrl: json['image_url'],
      linkUrl: json['link_url'],
      displayDuration: json['display_duration'],
      transitionTime: json['transition_time'],
    );
  }
}