# Jenkins
## 命令
* service jenkins restart

## 使用
* 工作目录参数：%workspace%
* [提交代码触发](https://medium.com/@xfstart07/devops-gitlab-%E6%8F%90%E4%BA%A4%E4%BB%A3%E7%A0%81%E8%A7%A6%E5%8F%91-jenkins-%E9%83%A8%E7%BD%B2-43601d7baf34)
* [Pipeline发送邮件-email](https://blog.csdn.net/u011541946/article/details/84034272), [email-ext](http://ikeptwalking.com/using-email-ext-plugin-in-jenkins-pipeline/)
  * 多个附件: attachmentsPattern: 'test/forEmail*, test/myPdf3*'
* [Jenkins 添加配置Git账号密码凭据](https://blog.csdn.net/qq_40943363/article/details/104220944)，只是配置账号密码，具体对应系统或url，是使用时的url

### 坑
* (插件checkout + gitlfs + 时间改到以前)，会随机狗血的卡在(git lfs pull)下载不了，怀疑是插件做了强时间要求。

## 资料
* [Ubuntu安装](http://blog.csdn.net/fenglailea/article/details/25919367)
* [关闭部分日志功能](http://blog.csdn.net/qq_33588470/article/details/54647496)，javax.jmdns
* [jenkins credentials & git ssh 认证](http://blog.csdn.net/gw569453350game/article/details/51911179)
* [Process leaked file descriptors error on JENKINS](http://stackoverflow.com/questions/17024441/process-leaked-file-descriptors-error-on-jenkins)：-Dhudson.util.ProcessTree.disable=true
* [解决无法切换到jenkins用户的问题](http://blog.csdn.net/csfreebird/article/details/27968019)
* [jenkins 入门教程(上)](http://www.cnblogs.com/yjmyzz/p/jenkins-tutorial-part-1.html)
* [jenkins用户权限配置](https://www.jianshu.com/p/fca6c3ecde5d)，https://blog.csdn.net/xuhailiang0816/article/details/80307523
  1. 新建用户：管理用户页面(https://jenkins.com/securityRealm)新建用户
  1. 创建角色：ManageRoles页面(https://jenkins.com/role-strategy/manage-roles)添加"Project Roles"，Pattern是"projectName.*"
  1. 授权：AssignRoles页面(https://jenkins.com/role-strategy/assign-roles)的"Global Roles"和"Item Roles"分配角色给用户
* Jenkins workflow job: Use parameter as branch specifier
  * 解决方法：disable "Lightweight checkout" checkbox
* [Jenkins+Git 基于Tag进行构建](https://www.jianshu.com/p/b0989979066a)
* [job自带的源码管理下载时lfs的启用方法](https://medium.com/@priya_talreja/git-lfs-setup-in-jenkins-ee80879007e3)

### 数据目录结构
* Jenkins没有数据库，采用目录结构存储
* job的build结构是：/jobs/%job名%/builds/%build号%，如/jobs/www-abc/builds/1

## 流水线
### 资料
* [官方资料](https://www.jenkins.io/zh/doc/book/pipeline/)
* [官方示例](https://www.jenkins.io/doc/pipeline/examples/)
* [jenkins pipeline基础语法与示例](https://www.jianshu.com/p/f1167e8850cd)
* [Groovy语法](https://www.w3cschool.cn/groovy/)
* [常用环境变量](https://blog.csdn.net/qq_41030861/article/details/105171222)
* [片段生成器](http://%domain%/job/%jobName%/pipeline-syntax/)
  * [msbuild](https://jenkinsci.github.io/job-dsl-plugin/#method/javaposse.jobdsl.dsl.helpers.step.StepContext.msBuild)
```
msBuild直接脚本：https://horrell.ca/2018/12/21/recommendations-for-msbuild-in-a-jenkins-pipeline/
msBuild组件：默认不存在
msBuild {
  msBuildInstallation('MSBuild 1.5')
  buildFile('${PRODUCT_NAME}.sln')
  args('/t:Rebuild /p:Configuration=Release /p:Platform="x64"')
  passBuildVariables()
  continueOnBuildFailure()
  unstableIfWarnings()
}
```
* environment里只能是字符串，不能放list等
* [【Jenkins】Pipeline遇到的问题和解决方法](https://blog.csdn.net/DynastyRumble/article/details/105678447)

### 开发
* [json读写](https://blog.csdn.net/u011541946/article/details/83833289)
* [msBuild](https://jenkinsci.github.io/job-dsl-plugin/#method/javaposse.jobdsl.dsl.helpers.step.StepContext.msBuild)
* [Jenkins的Pipeline脚本在美团餐饮SaaS中的实践 - 美团技术团队](https://tech.meituan.com/2018/08/02/erp-cd-jenkins-pipeline.html)

#### groovy语法
* [Groovy集合（map）](https://blog.csdn.net/dora_310/article/details/52877750)
* [Groovy List 常用操作](https://blog.csdn.net/coderinchina/article/details/92081323)

#### 常用语法
```
// 局部变量使用
script里局部变量除了赋值和echo时要$和引号，其他都是直接使用。本质有2种使用方案："${PRODUCT}" PRODUCT
示例：
def pp="${PRODUCT}"
echo "I am ${PRODUCT}"
def productGitUrl=aaa.get(PRODUCT)

// 输入参数
要$和引号

// 代码下载方法，第二种可以拉lfs文件
dir("${PRODUCT_NAME}/abc") {
  git branch: '${branch}', credentialsId: CREDENTIAL, url: '${url}'
}
dir("${PRODUCT_NAME}/abc") {
  checkout([$class: 'GitSCM', branches: [[name: '${branch}']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'GitLFSPull']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: CREDENTIAL, url: '${url}']]])
}

// 参数判断
script {
  if (params.USE_OPENGL1 == true) { // bool
  }
  if (params.ARCH == "32") { // enum
  }

  def _targetPath="${packageName}/123" // 必须要有单引号或者双引号

  if (_targetPath == "123") {
  }

}
```

#### 使用groovy库
```
import java.net.URLEncoder
git_password = URLEncoder.encode("${GIT_PASSWORD}")
echo "${git_password}" // 必须要有单引号或者双引号
```
#### bash相关
* [jenkins pipeline中获取shell命令的标准输出或者状态](https://blog.csdn.net/liurizhou/article/details/86670092)
* [shell内的变量定义使用](https://stackoverflow.com/questions/34013854/jenkins-workflow-environment-variables-causing-a-failure/44296015),【加"\"】
* [获取shell命令的标准输出或执行状态](https://www.cnblogs.com/chenyishi/p/10943352.html)
```
text = sh(script: "<shell command>", returnStdout: true).trim() // 标准输出
result = sh(script: "<shell command>", returnStatus: true) // 执行状态

sh """
  _match=`ls`
  if [ -z \${_match} ] ;then
  fi
"""
```

### 共享库
* 采用groovy
* [官方共享库](https://www.jenkins.io/zh/doc/book/pipeline/shared-libraries/), [共享库](https://www.qikqiak.com/post/jenkins-shared-library-demo/)

```
1 共享库开发
新建共享库的git
写个静态类，如/vars/util.groovy
可以在里面使用linux的shell
sh """
  ls
"""
2 共享库设置到Jenkins
菜单 : 系统管理-系统设置-Global Pipeline Libraries。设置如下：
Library Name : 可以自定义，当前示例用了common
Default version : 共享库的git分支号
3 共享库使用(业务pipeline文件)
@Library('common')_
script {
  util.静态函数(参数)
}
```

## 插件
* [Jenkins 插件开发](https://www.chenshaowen.com/blog/how-to-develop-the-plugin-of-jenkins.html)
* [Jenkins 插件开发之旅：两天内从 idea 到发布](https://cloud.tencent.com/developer/article/1426418)
* [插件扩张点](https://www.jenkins.io/doc/developer/extensions/): 插件的继承类
* 脚本命令行: http://%jenkins%/script
```
重置build number
item = Jenkins.instance.getItemByFullName("jobName")
item.builds.each() { build ->
  build.delete()
}
item.updateNextBuildNumber(1)
```
* [官方市场](https://plugins.jenkins.io/)
