const serviceUrl = 'http://8.129.214.128:3001/api/';
// const serviceUrl = 'http://192.168.0.104:3001/api/';
const servicePath = {
  'login': serviceUrl + 'users/login',
  'register': serviceUrl + 'users/register',
  'getAccountInfo': serviceUrl + 'users/accountInfo',
  'slideshow': serviceUrl + 'homes/slideshow',
  'create': serviceUrl + 'articles/create',
  'articlelist': serviceUrl + 'articles/getlist',
  'token': serviceUrl + 'token/checkToken',
  'articleDetail': serviceUrl + 'articles/query',
  'deleteArticle': serviceUrl + 'articles/delete',
  'publishComment': serviceUrl + 'comments/push',
  'deleteComment': serviceUrl + 'comments/delete',
  // 查询是否点赞收藏文章
  'queryOperation': serviceUrl + 'users/operation/query',
  // 点赞收藏文章
  'addOperation': serviceUrl + 'users/operation/add',
  // 取消点赞收藏文章
  'canceloperation': serviceUrl + 'users/operation/cancel',
  'searchArticle': serviceUrl + 'search/article',
  // 查询关注
  'queryFollow': serviceUrl + 'users/follow/query',
  // 关注
  'addFollow': serviceUrl + 'users/follow/add',
  // 取消关注
  'cancelFollow': serviceUrl + 'users/follow/cancel',
  // 获取作品收藏关注粉丝等列表
  'getarrlist': serviceUrl + 'users/getarrlist',
  // 获取作品收藏关注粉丝等列表
  'setting': serviceUrl + 'users/setting',
  // 设计师相关
  'getDesignerList': serviceUrl + 'stylist/getlist',
};
