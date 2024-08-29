# git
## 流程
### 初始化
1. 从master克隆dev：git checkout master; git branch dev;

### 开发feature分支
1. 从dev克隆feature：git checkout dev; git branch V2.3_ft_pay_lyx;
1. 开发人员检出：git checkout V2.3_ft_pay_lyx;
1. feature合并回dev：git checkout dev; git merge V2.3_ft_pay_lyx;

### 开发release分支
1. 从dev克隆release：git checkout dev; git branch V2.3_rl_20161111;
1. 开发人员检出：git checkout V2.3_rl_20161111;
1. release合并回dev：
1. release合并到master（是一个发布版本。同时需要打标签）：

### 开发hotfix分支
1. 从master克隆hotfix：git checkout master; git branch V2.2_hf_123456-332452_wyq;
1. 开发人员检出：git checkout V2.2_hf_123456-332452_wyq;
1. hotfix合并回master：
1. hotfix合并到dev/release：

> hotfix时，当有一个release分支同时存在（当前版本快发布了，却发现上个版本的bug）。这个hotfix分支必须被合并到release分支而不是dev分支(release后续会合并到dev)。

### 部署环境
1. 获取代码(测试环境)：git -C DIR checkout dev; git -C DIR pull;
1. 部署

## 命令脚本
### branch/tag
1. git clone URL 目录 // 下载到指定目录，默认是仓库名。默认分支是master
1. git clone --depth 1 URL // 克隆最后一次commit。加快速度，会有信息吗？
1. git clone -b master --single-branch URL // 克隆指定的版本。加快速度，非本分支信息缺失
1. 显示当前分支：git branch
1. 显示所有分支，含远程分支：git branch -va
1. 显示分支的提交记录：git show-branch
1. 显示当前分支的版本号(commit id)：git rev-parse HEAD
1. 切换分支/标签
  1. 切换本地分支：git checkout 分支/tag/commit，git checkout branch1, git checkout tag1, git checkout commit1
  1. 下载远程分支并切换【下载前先git pull同步】：git checkout -b <本地分支> origin/<远程分支>，git checkout -b lb origin/rb
  1. 下载远程标签并切换【下载前先git pull同步】：git checkout -b <本地分支> origin/<远程tag>
1. 基于当前分支创建新分支/切换分支：git branch <分支>
1. 删除分支：git branch -d <分支>
1. 拉取所有tag : git fetch --tags
1. 只推送所有的tag：git push --tags
1. 删除tag：git tag -d <tag>
1. 删除远程所有tag：git fetch && git push origin --delete $(git tag -l)
1. 同步tag，pull时tag不会更新：git fetch origin tag <任意tag号>
1. 查看tag信息：git show <tag>

### commit
1. git checkout -b abc && git push origin abc:abc // 本地创建分支并推送到远程同名分支
1. git diff // 查看文件差异
1. [add命令](https://www.yiibai.com/git/git_add.html)
1. git add -f . && git commit -m "msg" && git push // 提交[包括隐藏文件]，如果仓库是空的，需要git push origin master:master
1. git add -f debug/bin/hi.dll // 添加特定文件，用于被忽略的目录或文件类型
1. 添加所有的文件，包括删除的[所有跟踪文件中被修改过或已删除文件,所有未跟踪的文件]：git add -A .
1. 查看所有的commit提交记录：git log
1. 查看所有的commit提交记录(含文件清单)：git log --name-status
1. 查看author的commit提交记录：git log --author="wangyaqi"
1. 基于时间范围查author的：git log --author="wangyaqi" --since="2020-01-01" --until="2020-07-01"
1. 查看最新的commit：git show
1. 查看指定commit的所有修改：git show commitSHA
1. 查看某次commit中具体某个文件的修改：git show commitSHA fileName
1. 查看commit属于哪个分支 git branch -r --contains commitSHA
1. [修改最近一次提交](https://blog.csdn.net/AlexAoMin/article/details/51244486) : git add . && git commit --amend && git push -f

### reset
* [Git中撤销提交](https://www.cnblogs.com/zhuxiaoxi/p/8532540.html)

| 状态 | 操作 |
| :-: | - |
| 已修改+未暂存；已暂存+未提交 | git reset --hard |
| 已提交+未推送 | git reset --hard origin/<远程分支> |
| 已推送 | 见《强制删除远程分支上的某次提交》 |

* [强制删除远程分支上的某次提交](http://blog.csdn.net/qqxiaoqiang1573/article/details/68074847)，操作不可逆，属于高风险操作。两种如下：
```
git reset --hard HEAD~1 && git push origin -f # 当前head所在commit-1，相当于后退一个commit
git reset --hard SHA && git push origin -f // 后退到指定sha的commit
```

### revert
1. git revert commitid // 单父亲的revert
1. git revert -m 1 commitid // 多父亲的revert，1代表被合并的分支(一般是主干，要选择保留哪个父亲)。如分支需要再次合并到主干，需把上次的revert再revert掉[原因](https://www.cnblogs.com/bescheiden/articles/10563651.html)

### 其他
1. git remote -v // 查看项目远程地址
1. git remote set-url origin <URL> // 修改项目远程地址
1. git status // 显示当前目录的文件情况。如未暂存，已暂存
1. git blame file_path // 显示文件内容的具体修改情况
1. git cat-file -p commitid // 显示提交号的具体内容
1. **指定在特定目录执行git：git -C <目录> 执行命令**
1. 拉取当前分支：git pull
1. 拉取分支：git pull <远程主机> <远程分支>:<本地分支>，git pull origin master:master
1. 合并分支(远程分支合并到当前分支)：git merge <远程分支>
1. 清除当前目录下所有没commit的管理文件的修改：git checkout .
1. 清除当前目录下所有非管理文件：git -C . clean -xdf
1. [Git查看和修改账户](https://blog.csdn.net/junloin/article/details/75197880), git config

## 操作
### 选择提交的分支
按照以下顺序选择：
1. release分支：bugfix(无bugfix分支的情况下)，需尽快发布的小改动和功能
1. dev分支：
  * 下个版本 && 小改动
  * 下个版本 && (新增功能 && 不修改原有逻辑)
1. feature分支：到了测试和发布阶段再合并回dev分支
  * !下个版本
  * 下个版本 && 调整功能
  * 下个版本 && (新增功能 && 修改原有逻辑)

### 贮藏文件
* 工作区代码贮藏，会记录来源分支
* 使用场景：有新工作要做（如bugfix）+ 当前工作区有不少修改了却无法提交的文件
* 贮藏当前工作区，切换到新工作，恢复当前工作区

### 打补丁
* 跨分支代码迁移
* 使用场景：提交了代码到主分支+该功能代码需要先发布上线
* 在主分支上选择该功能对应的所有提交，创建成一个补丁，在发布分支上应用本补丁

### 取消本地已提交但没远程推送的记录
1. 重置到commit前的上一个版本，常用mixed
  * soft：提交内容放在缓冲区(相当于git add了)
  * mixed：提交内容不放在缓冲区(相当于改动后什么都没操作，git add后等于soft)
  * hard：丢弃提交内容

### pull时冲突处理
#### 无commit(2种方法，推荐stash)
##### 贮藏处理
1. git stash // 改动贮藏
1. git pull
1. git stash pop // 改动的贮藏恢复
1. 手动解决冲突

##### 冲突处理
1. commit
1. “有commit”的处理流程

#### 有commit
1. pull，手工解决冲突
1. commit(解决冲突)merge版本
1. push

#### 冲突各方说明

| 方式 | 我的(LOCAL) | 他人(REMOTE) |
| :----: | ---- | ---- |
| 使用贮藏 | 本地文件 | 贮藏 |
| 分支A合并到分支B | B | A |
| 使用补丁 | 本地文件 | 补丁 |

### 合并(merge)
* [使用VSCode作为SourceTree的Diff和Merge工具](https://zhuanlan.zhihu.com/p/47852867)
* [merge-快进合并和非快进合并](https://blog.csdn.net/andyzhaojianhui/article/details/78072143)
  * 合并分支和被合并分支没有内容上的差异，就是说合并分支的每一个提交(commit)都已经存在被合并分支里，git会执行一个“快速向前”(fast forward)操作，不创建任何合并提交(commit),只是将合并分支指向被合并分支。
  * 非快进合并会生成合并提交(不包含任何代码改动)，可以让我们的提交历史更加的清晰。
* 合并后删除合并分支，历史commit还是会在
* [merge, squash merge, 和rebase merge](https://www.jianshu.com/p/ff1877c5864e)

| 方式 | 说明 | 优点 | 缺点 |
| :----: | ---- | ---- | ---- |
| merge | 提交历史原封不动的到被合并分支 | 记录commit的实际情况，方便查看 |  |
| squash merge | 合并分支的所有提交压缩成1次提交提交到被合并分支，相当于合并者把所有代码改动一次性移植到被合并分支 | feature分支合并只看到1个commit，整体看的更清楚 | 无法查看历史 |
| rebase | 保留提交的作者信息的同时可以修改commit历史。并行变串行。本质同补丁 | 保留提交信息同时使提交历史更加整洁 | 发生冲突时不容易定位问题，因为rewrite了history |

* 其他合并方式

| 方式 | 说明 |
| :----: | ---- |
| [cherry-pick](https://www.ruanyifeng.com/blog/2020/04/git-cherry-pick.html) | 指定commit列表 |
| [打补丁](https://my.oschina.net/sdlvzg/blog/1608861) | 指定文件列表或指定commit列表 |

* [Git - 分支的新建与合并](https://git-scm.com/book/zh/v2/Git-%E5%88%86%E6%94%AF-%E5%88%86%E6%94%AF%E7%9A%84%E6%96%B0%E5%BB%BA%E4%B8%8E%E5%90%88%E5%B9%B6)
* [Git – Fast Forward 和 no fast foward](https://my.oschina.net/yuzn/blog/82297)
* [多个commit合并成1个commit](https://segmentfault.com/a/1190000007748862)
* [冲突文件说明](https://blog.csdn.net/zhangbinsijifeng/article/details/49332615)
```
BASE是双方的父亲
<<<<<<< HEAD
我的 Current
=======
他人 Incoming
>>>>>>>6853e5ff961e684d3a6c02d4d06183b5ff330dcc Incoming branch/commit
```
#### 取消合并
1. 未commit(恢复index)：git merge --abort
1. 已commit未push：git reset --hard commitid
1. 已push：reset，revert

#### 分支B的多次提交合并成分组A的1次提交
1. git checkout A && git merge --squash B

### 变基(rebase)
#### rebase和merge比对
* merge和rebase的最终结果没有任何区别
* https://www.waynerv.com/posts/git-rebase-intro/
* https://xiaozhuanlan.com/topic/6873210549
* https://git-scm.com/book/zh/v2/Git-%E5%88%86%E6%94%AF-%E5%8F%98%E5%9F%BA
* https://blog.csdn.net/kuangdacaikuang/article/details/79619828

#### 说明
* 作者和message都可以变、时间和提交号都会变
* 取消变基rebase：git rebase --abort
* git rebase --continue是继续下一个事项(有冲突需先解决)，最后一个事项做完后会自动完成rebase
* 核武器级选项：filter-branch
* [多个commit通过rebase调整成1个commit](https://blog.csdn.net/Spade_/article/details/108698036)

#### [主干(rebase)合并到分支](https://backlog.com/git-tutorial/cn/stepup/stepup2_8.html)
1. 主干到指定位置(否则是合并主干全部提交)：git checkout master && git reset --hard HEAD~
1. 合并：git checkout tmmm && git pull && git rebase master
1. 提交：git push

#### [重写历史](https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E9%87%8D%E5%86%99%E5%8E%86%E5%8F%B2)
> 重新排序提交, 修改提交信息, 压缩提交, 拆分提交

1. 压缩提交(多个提交合并成1个提交)，被合并的多个提交会物理删除
    1. 确保工作目录没有未提交的更改
    1. 启动rebase，rebase到的是**要合并的首个提交**。可以从指定的commit开始，或者后退几个开始
        1. git rebase -i abcdef123456^
        1. git rebase -i HEAD~5
    1. 首个是pick，其他改成s。保存退出
    1. 编辑合并的msg。保存退出
    1. git push --force

### 仓库迁移
* https://help.github.com/cn/articles/duplicating-a-repository

### 重置目录
* [重置目录到服务器状态](https://bitmingw.com/2018/01/28/git-branch-factory-reset/)

```
src_path=.
branch_name=dev
git -C ${src_path} fetch
git -C ${src_path} reset --hard
git -C ${src_path} clean -d -fx
git -C ${src_path} checkout ${branch_name}
git -C ${src_path} pull
```

### 信息获取
* git -C $3 symbolic-ref --short -q HEAD // 分支
* git -C $3 describe --always --tag // 标签
* git -C $3 rev-parse --short HEAD // 提交

### 清除已删除的文件(其存在于历史提交中)
[寻找并删除Git记录中的大文件](https://harttle.land/2016/03/22/purge-large-files-in-gitrepo.html)
```
// 下载全部分支
git clone --bare <git_url>
// 获取前十个最大的文件
git rev-list --objects --all | grep "$(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | tail -10 | awk '{print$1}')"
// 将文件名存入large_files.txt，基于文件清除
git filter-branch -f --prune-empty --index-filter "git rm -rf --cached --ignore-unmatch `cat large_files.txt`" --tag-name-filter cat -- --all
// 如果文件所在目录删除了，就无法清除文件了，只能清除目录
git filter-branch -f --prune-empty --index-filter 'git rm -rf --cached --ignore-unmatch 相对目录' --tag-name-filter cat -- --all
// 提交到远程仓库
git push origin --all -f
```

### 提交失败相关处理
```
设置大缓存，用于大文件提交失败：git config --global http.postBuffer 52428000
显示命令的详细信息，用于提交失败原因定位：export GIT_CURL_VERBOSE=1
显示所有配置：git config -l
```

### 统计
1. 统计工具：cloc, git_stats
1. [统计脚本](https://blog.csdn.net/weixin_34277853/article/details/89700887)
```
echo "统计结果:" && git log --first-parent master --author="andrew" --after="2018-09-16 12:00:00" --before="2019-09-16 00:00:01" --pretty=tformat: --numstat | gawk '{ add += $1 ; subs += $2 ; loc += $1 - $2 } END { printf "增加行数:%s 删除行数:%s 变化总行数:%s\n",add,subs,loc }'
echo "详情如下:" && git log --first-parent master --author="andrew" --word-diff --since="2019-05-16 00:00:01" --until="2019-09-16 12:00:00" -p --stat
```

### 同一台电脑上的仓库目录用不同账号提交
1. 相同或不同仓库都可以
1. 操作如下，核心是设置仓库实例的git账号信息
```
cd 仓库目录
git config --local user.name NAME
git config --local user.email NAME@email.com
git config --local user.password PASSWORD
```

### 下载部分文件
* 只能生效一次，再做需要重头操作
* 支持多层目录
```
git init && git config core.sparseCheckout true && echo "design/" >> .git/info/sparse-checkout
git remote add -f origin url && git pull origin master
```

### 重置branch
* [重置branch](https://blog.csdn.net/weixin_33974433/article/details/87963137)
* 结果是重建分支，一般用于master。其他分支直接删除即可。
```
思路：用空分支替换需重置的branch(master)，注意其tag无法自动清除
步骤：
git clone并进入目录
git checkout master && git checkout --orphan new_branch && rm * -rf && rm -f .gitattributes .gitignore // 创建孤儿空分支，清空
echo linux > README.md && git add -A && git commit -am "Initial commit" // 空分支加一个文件，没有文件无法创建commit，就没法替换master
git branch -D master && git branch -m master && git push -f origin master // 删除master，将空分支提交到master
```

### 下载失败-压缩导致内存不做
```
错误：
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed
```

```
关闭压缩：
命令行：git config --global core.compression 0
.gitconfig文件：
[core]
    compression = 0
```

### 账号密码记忆设置
* [git账号密码记忆的设置](http://blog.csdn.net/guang11cheng/article/details/50537759)
  1. 如果是docker容器需要做这一步。将容器内的.root目录映射到宿主机持久化，修改文件后重启容器: 在docker-compose.yml的volumes段落增加映射，比如“/home/user/wangyaqi/root:/root”
  1. git config --global credential.helper store
  1. git操作，再输1次密码
* rm ~/.git-credentials // 取消账号密码记忆

1. 忽略SSL证书：git config --global http.emptyAuth true

### git和编辑器的LF设置
```
// atom
Settings -> Packages -> Line Ending Selector -> change the “Default line ending” setting to “LF” instead of “OS Default”.
// Git : https://blog.csdn.net/weixin_33859665/article/details/93834202
git config --global core.autocrlf false
git config --global core.safecrlf true
```

### gitlfs
#### 安装和配置
1. [安装详见gitlab](./soft/dev/gitlab)
1. gitlfs安装后默认git clone是下载lfs文件的
1. 不下载lfs文件 配置: git config --global filter.lfs.smudge "git-lfs smudge --skip"
1. 下载lfs文件 配置: git config --global filter.lfs.smudge "git-lfs smudge -- %f"

#### 操作
1. [Git LFS 操作指南](https://zzz.buzz/zh/2016/04/19/the-guide-to-git-lfs/)
1. 设置活跃超时秒数，解决客户端上传失败(read tcp i/o timeout)：git config --global lfs.activitytimeout 3600
1. 设置不压缩：git config --global core.compression 0
1. 设置上传buffer，一般都够的：git config --global http.postBuffer 5368709120
1. 设置通讯协议：git config --global http.version HTTP/1.1
1. [git-lfs-config](https://github.com/git-lfs/git-lfs/blob/main/docs/man/git-lfs-config.5.ronn)

### 输入类型判断: 分支/tag/sha
判断commit的类型
```
_match=`git -C ${path} branch -r | grep -w origin/${commit}` || _match=
if [ ! -z "${_match}" ] ;then # branch匹配
  return 1
fi
_match=`git -C ${path} tag -l | grep -w ${commit}` || _match=
if [ ! -z "${_match}" ] ;then # tag匹配
  return 2
fi
_match=`git -C ${path} show -s ${commit} | grep -w commit` || _match=
if [ ! -z "${_match}" ] ;then # sha匹配
  return 3
fi
```

### 获取仓库的sha
```
_sha=`git -C ${path} rev-parse HEAD`
```

### 同步和远程tag一致
* 远程tags删除了但本地一直在
```
git tag -l | xargs git tag -d && git fetch origin --prune # 删除所有本地分支，从远程拉取所有信息
```

### gitlab的开发分支合并到主干
1. master合并到dev（有冲突时使用我的）
1. 发起MR(dev合并到master)，启用“Squash commits when merge request is accepted”

* 如果没有启用Squash导致提交历史乱了，可在master合并前的commit上拉新分支，即可恢复原来的历史

### submodule
* [submodule命令](https://juejin.cn/post/6948251963133788196)
```
git submodule add <子模块git地址> <存放的文件名>
git submodule update --init --recursive
```
* [submodule子模块的管理和使用](https://www.jianshu.com/p/9000cd49822c)
    1. CMAKE_SOURCE_DIR是基于项目的
    1. 项目记录了通用模块仓库的Commit

## 资料
### 参考
1. [版本模型和最佳实践](https://rd.wangyaqi.cn/#/dev/model)
1. [Learn Git Branching](https://learngitbranching.js.org/)，很好的示范实例
1. [Git常用命令速查表](https://www.w3cschool.cn/git/git-cheat-sheet.html)
1. [Git常用命令备忘录](https://bbs.huaweicloud.com/blogs/320900)
1. [猴子都能懂的GIT入门](https://backlog.com/git-tutorial/cn/intro/intro5_2.html)
1. **[git push & git pull 推送/拉取分支](http://blog.csdn.net/litianze99/article/details/52452521)**
1. [git – 简易指南](http://www.bootcss.com/p/git-guide/)
1. [Git下的冲突解决](http://www.cnblogs.com/sinojelly/archive/2011/08/07/2130172.html)
1. [git多账号提交适配](https://www.jianshu.com/p/d696b5fef750)
1. [git中detached HEAD、amend、rebase和reset](https://cloud.tencent.com/developer/article/1446002)
1. [Detached HEAD](https://zhuanlan.zhihu.com/p/66460426)
1. 分支整体图用TortoiseGit的[Reversion Graph](https://blog.csdn.net/zh_ITRoad/article/details/84857531)
1. [在gitignore文件中设置""无视忽略"](https://blog.csdn.net/lucky__peng/article/details/124094548) : !/dist/img

### 账号
1. git账号：通过邮箱区分
  1. author：作者，通过commit命令添加
  1. committer：提交者，通过配置添加
    1. 全局配置: /user/NAME/.gitconfig
1. 服务商账号：服务商自定义，比如github账号密码

### 提交
1. git的author时间是提交电脑操作(git commit)是的本机时间，不是服务器的。git 修改上次git commit的时间: git commit --amend --date="Sun, 25 Dec 2016 19:42:09 +0800"
1. github提交时不会检查服务商账号是否和git的committer一致，所以只要有github仓库权限就可以伪造成其他人的提交
1. github仓库首次输入会记忆

### 安装
1. [Windows安装包](https://www.newbe.pro/Mirrors/Mirrors-Git-For-Windows/)
1. [centos7编译安装](http://blog.csdn.net/chrislyl/article/details/70876682)，[参考2](http://blog.csdn.net/zongyinhu/article/details/54695404)
  * 脚本

```
// 依赖库
yum -y install autoconf

yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel  -y #以下四行是：安装git的依赖包
yum install curl libcurl4-openssl-dev perl cpio expat asciidoc docbook2x -y
yum install cpan -y
yum install perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker -y

// 下载
wget https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.gz
tar zxvf git-2.9.3.tar.gz
cd git-2.9.3

// 安装
autoconf
./configure
make
make install
```

### github
* 账号密码不能登录的2个解决方法
  1. git的url加PAT : https://${PersonAccessToken}@github.com/username/repo.git
  1. [git标准url和账号，但密码用token](https://www.cnblogs.com/plpeng/p/15175315.html)
