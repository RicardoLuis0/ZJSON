mkdir -p generated/ZJSON
cp -r ./ZJSON/. generated/ZJSON/

if [ $# -eq 0 ]; then
    replacee=""
else
    replacee="$1_"
fi

find generated/ZJSON -name "*.zs" -exec sed -i "s/placeholder_/$replacee/g" {} \;
