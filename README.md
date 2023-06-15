# Odoo-addons-dev
VSCodeとDockerを組み合わせたOdooのカスタムモジュール用アドオン開発環境のテンプレート。  
Add-ons development environment template for Odoo's custom modules that combines VSCode and Docker.  


# はじめに Get Started

本テンプレートは、Odooのカスタムモジュール用アドオン開発環境のテンプレートです。  
This template is add-ons development environment template for Odoo's custom modules.

VSCodeとDockerを組み合わせているため、簡単にOdooのカスタムモジュール用アドオン開発環境を構築でき、すぐに開発を始めることができます。もちろん、Odoo標準のアプリケーションの動作検証を行うこともできます。  
With the combination of VSCode and Docker, you can easily build add-ons development environment for Odoo's custom modules and start developing right away. Of course, you can also verify the operation of standard Odoo applications.

次のツールをインストールしてください。  
Install the following tools.  

1. [git](https://git-scm.com/)
1. [VSCode](https://code.visualstudio.com/download)
1. [Docker](https://www.docker.com/)


# 使い方 How to use

## Using this template

1. GitHubのリポジトリを開きます。  
   Open the repository on github.  
   https://github.com/jp-rad/odoo-addons-dev

1. `Use this template`をクリックします。  
   Click `Use this template`.  
   [Here - https://github.com/jp-rad/odoo-addons-dev/generate](https://github.com/jp-rad/odoo-addons-dev/generate)


## git clone

1. コマンドプロンプトを開き、次のコマンドを実行します。  
Open the command prompt and run below commands.

```CommandPrompt.cmd
mkdir c:\workgit
cd c:\workgit
git clone <your GitHub Code URL>
```

## VSCode, Reopen in Container

1. VSCodeで、git cloneしたフォルダを開きます。  
Open the git cloned folder in VSCode.  
1. VSCodeに拡張機能「Remote - Containers」をインストールします。  
Install the "Remote - Containers" extension to VSCode.
1. VSCodeの左下に拡張機能「Remote - Containers」のアイコンが追加されますので、そのアイコンをクリックします。  
An icon for the extension "Remote - Containers" will be added to the bottom left corner of VSCode, click on that icon.  
1. 「Remote-Containers: Reopen in Container」をリストから選択します。  
Select "Remote-Containers: Reopen in Container" from the list.
1. Dockerコンテナーが起動し、VSCodeからリモート開発ができるようになります。  
The Docker container will start and you will be able to develop remotely from VSCode.


## custom_addons

1. 「custom_addons」フォルダ内で、アドオンの開発が可能です。Odooチュートリアル等を参考にしてください。  
You can develop your own add-ons in "custom_addons" folder, see the Odoo tutorials, etc.  
https://www.odoo.com/documentation/master/developer/howtos/backend.html
1. 空のモジュールを新規追加するには、次のコマンドを実行します。  
To add a new empty module, issue the following command
```
/opt/odoo/odoo/odoo-bin scaffold <module name>
```

## Log in to Odoo

1. VSCodeの左にある「Debug and Run」アイコンをクリックし、「Odoo addons」を選んだ状態で、「Start Debugging」アイコンをクリックすると、Odooが起動します。  
Click on the "Debug and Run" icon on the left of VSCode, and with "Odoo addons" selected, click on the "Start Debugging" icon to start Odoo.
1. Odooが起動したら、ブラウザーを開き、Odooにアクセスして、ログインしてください（admin/admin）。  
Once Odoo is running, open your browser, access Odoo, and log in (admin/admin).  
http://localhost/
