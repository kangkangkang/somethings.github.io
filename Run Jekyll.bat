@echo off
cd /d F:\Code\MyBlog\ray-eldath.github.io
del /S /Q F:\Code\MyBlog\ray-eldath.github.io\_site
bundle exec jekyll serve --watch
