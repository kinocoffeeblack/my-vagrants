#!/bin/bash

# 呼び出し方例) source /vagrant/getSessionToken.sh XXXXXX(TOKEN_CODE)

TOKEN_CODE=${1}

if [ -z "$TOKEN_CODE" ]; then
   echo "please input TOKEN_CODE at first parameter."
   return
fi

# Edit to your Environment
AWS_ACCOUND_ID=YOUR_AWS_ACCOUNT_ID
AWS_IAM_USER=YOUR_USERNAME_WITH_MFA

# AWS_ACCESS_KEY_ID、AWS_SECRET_ACCESS_KEY、AWS_SESSION_TOKENを環境変数に設定
# "Expiration"は環境変数に必要ないので一時的にShell変数に設定して標準出力だけしている
# --duration-secondsは有効期限の指定(デフォルトが12h=43200)
eval `aws sts get-session-token --serial-number arn:aws:iam::${AWS_ACCOUND_ID}:mfa/${AWS_IAM_USER} --token-code ${TOKEN_CODE} --duration-seconds 43200 | awk '
 $1 == "\"AccessKeyId\":" { gsub(/\"/,""); gsub(/,/,""); print "export AWS_ACCESS_KEY_ID="$2 }
 $1 == "\"SecretAccessKey\":" { gsub(/\"/,""); gsub(/,/,""); print "export AWS_SECRET_ACCESS_KEY="$2 }
 $1 == "\"SessionToken\":" { gsub(/\"/,""); gsub(/,/,""); print "export AWS_SESSION_TOKEN="$2 }
 $1 == "\"Expiration\":" { gsub(/\"/,""); gsub(/,/,""); print "SESSION_TOKEN_EXPIRATION="$2 }
'`

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
   echo "get-session-token failure."
   return
fi

echo "SUCCESS. SesstionToken-Expiration is ${SESSION_TOKEN_EXPIRATION}（JST: `date --date=${SESSION_TOKEN_EXPIRATION} '+%Y/%m/%d %H:%M:%S'`）"
