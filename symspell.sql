create or replace function symspellD1 as word ->
    arrayPushBack(
        arrayMap(i ->
            substr(upper(word), 1, i - 1) || substr(upper(word), i + 1),
            range(1, length(word) + 1)),
        upper(word));


create or replace function symspellD2 as word ->
    arrayDistinct(
        arrayFilter(x -> x != '',
            arrayConcat(
                symspellD1(word),
                arrayFlatten(
                    arrayMap(
                        w -> symspellD1(w),
                        symspellD1(word))))));

create or replace function symspellD1HashBitmap as word ->
    bitmapBuild(
        arrayMap((e) ->
            sipHash64(e), symspellD1(upper(word))));

create or replace function symspellD2HashBitmap as word ->
    bitmapBuild(
        arrayMap((e) ->
            sipHash64(e), symspellD2(upper(word))));

