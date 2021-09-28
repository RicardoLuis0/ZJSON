if [ $# -eq 0 ]; then
    replacee=""
else
    replacee="$1_"
fi


mkdir -p "generated/${replacee}ZJSON"
cp -r ./ZJSON/. "generated/${replacee}ZJSON/"


find "generated/${replacee}ZJSON/" -name "*.zs" -exec sed -i "s/placeholder_/$replacee/g" {} \;
