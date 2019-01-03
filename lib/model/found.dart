class Found {
  final String avatar;
  final String title;
  final int isWidth;

  const Found(this.avatar, this.title, this.isWidth);
}

class FoundItem {
  final List<Found> founds = [
    const Found('assets/images/ic_social_circle.png', '朋友圈', 0),
    const Found('assets/images/ic_quick_scan.png', '扫一扫', 1),
    const Found('assets/images/ic_shake_phone.png', '摇一摇', 0),
    const Found('assets/images/ic_feeds.png', '看一看', 1),
    const Found('assets/images/ic_quick_search.png', '搜一搜', 0),
    const Found('assets/images/ic_people_nearby.png', '附近的人', 1),
    const Found('assets/images/ic_bottle_msg.png', '漂流瓶', 1),
    const Found('assets/images/ic_shopping.png', '购物', 0),
    const Found('assets/images/ic_game_entry.png', '游戏', 0),
    const Found('assets/images/ic_mini_program.png', '小程序', 1),
  ];

  static FoundItem mock(){
    return FoundItem();
  }
}