CREATE OR REPLACE FUNCTION _metaphoneDedup AS (token) -> (
    arrayStringConcat(
        arrayFilter(
            (c) -> c != '',
            arrayMap(
                (v) -> multiIf(
                    v.2 = 1, v.1,
                    v.1 = 'c' OR v.1 != arrayElement(arrayZip(splitByString('', token), arrayEnumerate(splitByString('', token))), v.2 - 1).1, v.1,
                    ''
                ),
            arrayZip(splitByString('', token), arrayEnumerate(splitByString('', token))))
        )
    )
);

CREATE OR REPLACE FUNCTION _metaphoneDropInitialLetters AS (token) ->
    if(match(token, '^(kn|gn|pn|ae|wr)'), substring(token, 2), token);

CREATE OR REPLACE FUNCTION _metaphoneDropBafterMAtEnd AS (token) ->
    replaceRegexpAll(token, 'mb$', 'm');

CREATE OR REPLACE FUNCTION _metaphoneCTransform AS (token) ->
    replaceRegexpAll(
        replaceRegexpAll(
            replaceRegexpAll(
                replaceRegexpAll(token, '([^s]|^)(c)(h)', '\\1x\\3'),
                'cia', 'xia'
            ),
            'c(i|e|y)', 's\\1'
        ),
        'c', 'k'
    );

CREATE OR REPLACE FUNCTION _metaphoneDTransform AS (token) ->
    replaceRegexpAll(
        replaceRegexpAll(token, 'd(ge|gy|gi)', 'j\\1'),
        'd', 't'
    );

-- Add the rest of the transformation functions here...
CREATE OR REPLACE FUNCTION _metaphoneDropG AS (token) ->
    replaceRegexpAll(
        replaceRegexpAll(token, 'gh(^$|[^aeiou])', 'h\\1'),
        'g(n|ned)$', '\\1'
    );

CREATE OR REPLACE FUNCTION _metaphoneTransformG AS (token) ->
    replaceRegexpAll(
        replaceRegexpAll(
            replaceRegexpAll(token, '([^g]|^)(g)(i|e|y)', '\\1j\\3'),
            'gg', 'g'
        ),
        'g', 'k'
    );

CREATE OR REPLACE FUNCTION _metaphoneDropH AS (token) ->
    replaceRegexpAll(token, '([aeiou])h([^aeiou])', '\\1\\2');

CREATE OR REPLACE FUNCTION _metaphoneTransformCK AS (token) ->
    replaceRegexpAll(token, 'ck', 'k');

CREATE OR REPLACE FUNCTION _metaphoneTransformPH AS (token) ->
    replaceRegexpAll(token, 'ph', 'f');

CREATE OR REPLACE FUNCTION _metaphoneTransformQ AS (token) ->
    replaceRegexpAll(token, 'q', 'k');

CREATE OR REPLACE FUNCTION _metaphoneTransformS AS (token) ->
    replaceRegexpAll(token, 's(h|io|ia)', 'x\\1');

CREATE OR REPLACE FUNCTION _metaphoneTransformT AS (token) ->
    replaceRegexpAll(
        replaceRegexpAll(token, 't(ia|io)', 'x\\1'),
        'th', '0'
    );

CREATE OR REPLACE FUNCTION _metaphoneDropT AS (token) ->
    replaceRegexpAll(token, 'tch', 'ch');

CREATE OR REPLACE FUNCTION _metaphoneTransformV AS (token) ->
    replaceRegexpAll(token, 'v', 'f');

CREATE OR REPLACE FUNCTION _metaphoneTransformWH AS (token) ->
    replaceRegexpAll(token, '^wh', 'w');

CREATE OR REPLACE FUNCTION _metaphoneDropW AS (token) ->
    replaceRegexpAll(token, 'w([^aeiou]|$)', '\\1');

CREATE OR REPLACE FUNCTION _metaphoneTransformX AS (token) ->
    replaceRegexpAll(
        replaceRegexpAll(token, '^x', 's'),
        'x', 'ks'
    );

CREATE OR REPLACE FUNCTION _metaphoneDropY AS (token) ->
    replaceRegexpAll(token, 'y([^aeiou]|$)', '\\1');

CREATE OR REPLACE FUNCTION _metaphoneTransformZ AS (token) ->
    replaceRegexpAll(token, 'z', 's');

CREATE OR REPLACE FUNCTION _metaphoneDropVowels AS (token) ->
    concat(
        substring(token, 1, 1),
        replaceRegexpAll(substring(token, 2), '[aeiou]', ''));

CREATE OR REPLACE FUNCTION metaphone AS (s) -> (
    upper(
    _metaphoneDropVowels(
    _metaphoneTransformZ(
    _metaphoneDropY(
    _metaphoneDropW(
    _metaphoneTransformWH(
    _metaphoneTransformV(
    _metaphoneDropT(
    _metaphoneTransformT(
    _metaphoneTransformX(
    _metaphoneTransformS(
    _metaphoneTransformQ(
    _metaphoneTransformPH(
    _metaphoneDropH(
    _metaphoneTransformG(
    _metaphoneDropG(
    _metaphoneDTransform(
    _metaphoneCTransform(
    _metaphoneTransformCK(
    _metaphoneDropBafterMAtEnd(
    _metaphoneDropInitialLetters(
    _metaphoneDedup(s)
    )))))))))))))))))))))
);
