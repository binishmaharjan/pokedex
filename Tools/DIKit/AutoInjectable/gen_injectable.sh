#!/bin/bash

################################################
# *.swift 内に定義されている `AutoInjectable` の数を検索して、その数が
# 前回の数(.autoInjectable)から変化していたら `make di` 内のスクリプト `resolve.sh` を実行する
# .autoInjectable に前回にヒットした `AutoInjectable` の数を保存する
################################################

SECONDS=0

TOOLPATH="Tools/DIKit"
CACHE_FILE="$TOOLPATH/AutoInjectable/.autoInjectable"

if [[ ! -e $CACHE_FILE ]]; then
  # ファイルが存在しない場合の初期データ
  echo "[digen] gen $CACHE_FILE"
  echo "0" > $CACHE_FILE
fi

prev_count=`cat $CACHE_FILE`

grep "AutoInjectable" -rl --include='*.swift' App/* | wc -l | xargs > $CACHE_FILE

current_count=`cat $CACHE_FILE`

if [ $prev_count != $current_count ]; then
  # 定義されている AutoInjectable の数に変化があれば実行
  echo "[digen] run resolve.sh"
  sh $TOOLPATH/resolve.sh
else
  echo "[digen] no updates.."
fi

time=$SECONDS

echo "[digen] process_time: $time"
