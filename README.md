# 翰

“翰”是一款 iA Writer 主题模板，旨在美化中英文混合输入下文字的预览和排版。“翰”使用了两种字体：

- 中文字体[霞鹜文楷](https://github.com/lxgw/LxgwWenkai)
- 西文字体[Maple Mono](https://github.com/subframe7536/maple-font)

# 开始使用


`./build.sh` 或从 release 页面下载。将生成的 `han.iatemplate` 倒入 iA Writer，在预览中选中 han 模板。

## 自动构建与发布

每次推送 `main` 分支时，GitHub Actions 都会自动构建 `han.iatemplate.zip`，并更新 GitHub Releases 页面上的 **Continuous build** 预发布版本。

要发布正式版本，推送一个 `v` 开头的 tag，例如：

```sh
git tag v1.0.0
git push origin v1.0.0
```

GitHub Actions 会自动创建 `Han v1.0.0`，并把 `han.iatemplate.zip` 附到该 Release 上。
