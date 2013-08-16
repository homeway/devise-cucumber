#language: zh-CN
功能: 查看微博

  背景: 当用户已经发了一条微博信息
    实际上，这个背景适同样用于删除和编辑的场景，只有新建微博时才不需要：）

    假如已经有一个用户
    而且这个用户发了一条信息“这是我的第一条微博”

  场景: 查看用户发的微博信息
    当我访问这个用户的页面时
    那么我应该能在这个用户的信息列表中找到这条信息
    而且这条信息应该在按时间顺序排在最前位置

  场景: 查看单个条目的微博信息
    当我可以单独打开这条信息
    那么我应该能看到“这是我的第一条微博”这条信息的单独界面