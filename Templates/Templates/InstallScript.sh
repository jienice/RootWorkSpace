#!/bin/sh

#  InstallScript.sh
#  Templates
#
#  Created by jie.xing on 2021/7/23.
#

read -p "TemplateSourcePath: " TemplateSource
read -p "TemplateName: " TemplateName

cp -R $TemplateSource ~/Library/Developer/Xcode/Templates/Custom\ Templates/$TemplateName.xctemplate
