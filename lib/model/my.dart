class My {
  final String avatar;
  final String title;
  final int isWidth;

  const My(this.avatar, this.title, this.isWidth);
}

class MyItem {
  final List<My> mys = [
    const My('assets/images/ic_wallet.png', '钱包', 1),
    const My('assets/images/ic_collections.png', '收藏', 1),
    const My('assets/images/ic_album.png', '相册', 0),
    const My('assets/images/ic_cards_wallet.png', '卡包', 0),
    const My('assets/images/ic_emotions.png', '表情', 0),
    const My('assets/images/ic_settings.png', '设置', 1),
  ];

  static MyItem mock(){
    return MyItem();
  }
}