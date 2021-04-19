import 'dart:io';

Socket socket;

const mockVideo =
    'http://baishan.oversketch.com/2019/11/05/d07f2f1440e51b9680f4bcfe63b0ab67.MP4';
const mV2 =
    'http://8.129.214.128:3001/upload/videos/videos_a3d5cc64-e4a1-4422-99aa-4be7d8b2aca2_single.mp4';
const mV3 =
    'http://baishan.oversketch.com/2020/05/14/55eae3664003437b80a159a9f2369474.MP4';
const mV4 =
    'http://baishan.oversketch.com/2020/05/14/59e0c1dd40bd4f41804f33814ad4b67a.MP4';

class UserVideo {
  final String url;
  final String title;
  final String desc;

  UserVideo({
    this.url: mockVideo,
    this.title,
    this.desc,
  });
  static List<UserVideo> fetchVideo() {
    List<UserVideo> list = [];
    list.add(UserVideo(url: mockVideo, title: 'test', desc: '罗永浩'));
    list.add(UserVideo(url: mV2, title: 'test', desc: 'MV_TEST_2'));
    list.add(UserVideo(url: mV3, title: 'test', desc: 'MV_TEST_3'));
    list.add(UserVideo(url: mV4, title: 'test', desc: 'MV_TEST_4'));
    return list;
  }
}
