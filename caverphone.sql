/*
Caverphone 2.0
Start with a word
Convert to lowercase
Remove anything not in the standard alphabet (typically a-z)[note 1]
Remove final e
If the name starts with
- cough make it cou2f
- rough make it rou2f
- tough make it tou2f
- enough make it enou2f
- trough make it trou2f
- gn make it 2n
If the name ends with
- mb make it m2
Replace
- cq with 2q
- ci with si
- ce with se
- cy with sy
- tch with 2ch
- c with k
- q with k
- x with k
- v with f
- dg with 2g
- tio with sio
- tia with sia
- d with t
- ph with fh
- b with p
- sh with s2
- z with s
- an initial vowel[note 2] with an A
- all other vowels with a 3
- j with y
- an initial y3 with Y3
- an initial y with A
- y with 3
- 3gh3 with 3kh3
- gh with 22
- g with k
- groups of the letter s with a S
- groups of the letter t with a T
- groups of the letter p with a P
- groups of the letter k with a K
- groups of the letter f with a F
- groups of the letter m with a M
- groups of the letter n with a N
- w3 with W3
- wh3 with Wh3
- if the name ends in w replace the final w with 3
- w with 2
- an initial h with an A
- all other occurrences of h with a 2
- r3 with R3
- if the name ends in r replace the final r with 3
- r with 2
- l3 with L3
- if the name ends in l replace the final l with 3
- l with 2
remove all 2s
if the name end in 3, replace the final 3 with A
remove all 3s
put ten 1s on the end
take the first ten characters as the code
*/

-- Caverphone 2.0 implementation
CREATE OR REPLACE FUNCTION _caverphoneToLower AS (token) -> (
    lower(token)
);

CREATE OR REPLACE FUNCTION _caverphoneRemoveNonAlpha AS (token) -> (
    replaceRegexpAll(token, '[^a-z]', '')
);

CREATE OR REPLACE FUNCTION _caverphoneRemoveFinalE AS (token) -> (
    replaceRegexpAll(token, 'e$', '')
);

-- Add the rest of the transformation functions here...
CREATE OR REPLACE FUNCTION _caverphoneReplaceInitial AS (token) -> (
    replaceRegexpAll(
        replaceRegexpAll(
            replaceRegexpAll(
                replaceRegexpAll(
                    replaceRegexpAll(token, '^cough', 'cou2f'),
                    '^rough', 'rou2f'
                ),
                '^tough', 'tou2f'
            ),
            '^enough', 'enou2f'
        ),
        '^trough', 'trou2f'
    )
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceGn AS (token) -> (
    replaceRegexpAll(token, '^gn', '2n')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceMb AS (token) -> (
    replaceRegexpAll(token, 'mb$', 'm2')
);

-- Add the rest of the transformation functions here...
CREATE OR REPLACE FUNCTION _caverphoneReplaceCq AS (token) -> (
    replaceAll(token, 'cq', '2q')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceCiCeCy AS (token) -> (
    replaceRegexpAll(
        replaceRegexpAll(
            replaceRegexpAll(token, 'ci', 'si'),
            'ce', 'se'
        ),
        'cy', 'sy'
    )
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceTch AS (token) -> (
    replaceRegexpAll(token, 'tch', '2ch')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceC AS (token) -> (
    replaceAll(token, 'c', 'k')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceQ AS (token) -> (
    replaceAll(token, 'q', 'k')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceX AS (token) -> (
    replaceAll(token, 'x', 'k')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceV AS (token) -> (
    replaceAll(token, 'v', 'f')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceDg AS (token) -> (
    replaceRegexpAll(token, 'dg', '2g')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceTioTia AS (token) -> (
    replaceRegexpAll(
        replaceRegexpAll(token, 'tio', 'sio'),
        'tia', 'sia'
    )
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceD AS (token) -> (
    replaceAll(token, 'd', 't')
);

CREATE OR REPLACE FUNCTION _caverphoneReplacePh AS (token) -> (
    replaceRegexpAll(token, 'ph', 'fh')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceB AS (token) -> (
    replaceAll(token, 'b', 'p')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceSh AS (token) -> (
    replaceRegexpAll(token, 'sh', 's2')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceZ AS (token) -> (
    replaceAll(token, 'z', 's')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceInitialVowel AS (token) -> (
    replaceRegexpAll(token, '^[aeiou]', 'A')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceVowels AS (token) -> (
    replaceRegexpAll(token, '[aeiou]', '3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceJ AS (token) -> (
    replaceAll(token, 'j', 'y')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceInitialY3 AS (token) -> (
    replaceRegexpAll(token, '^y3', 'Y3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceInitialY AS (token) -> (
    replaceRegexpAll(token, '^y', 'A')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceY AS (token) -> (
    replaceRegexpAll(token, 'y', '3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplace3gh3 AS (token) -> (
    replaceRegexpAll(token, '3gh3', '3kh3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceGh AS (token) -> (
    replaceRegexpAll(token, 'gh', '22')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceG AS (token) -> (
    replaceRegexpAll(token, 'g', 'k')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceGroups AS (token) -> (
    replaceRegexpAll(
        replaceRegexpAll(
            replaceRegexpAll(
                replaceRegexpAll(
                    replaceRegexpAll(
                        replaceRegexpAll(token, 'ss+', 'S'),
                        'tt+', 'T'
                    ),
                    'pp+', 'P'
                ),
                'kk+', 'K'
            ),
            'ff+', 'F'
        ),
        'mm+', 'M'
    )
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceGroupsN AS (token) -> (
    replaceRegexpAll(token, 'nn+', 'N')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceW3 AS (token) -> (
    replaceRegexpAll(token, 'w3', 'W3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceWh3 AS (token) -> (
    replaceRegexpAll(token, 'wh3', 'Wh3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceFinalW AS (token) -> (
    replaceRegexpAll(token, 'w$', '3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceW AS (token) -> (
    replaceAll(token, 'w', '2')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceInitialH AS (token) -> (
    replaceRegexpAll(token, '^h', 'A')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceH AS (token) -> (
    replaceAll(token, 'h', '2')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceR3 AS (token) -> (
    replaceRegexpAll(token, 'r3', 'R3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceFinalR AS (token) -> (
    replaceRegexpAll(token, 'r$', '3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceR AS (token) -> (
    replaceAll(token, 'r', '2')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceL3 AS (token) -> (
    replaceRegexpAll(token, 'l3', 'L3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceFinalL AS (token) -> (
    replaceRegexpAll(token, 'l$', '3')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceL AS (token) -> (
    replaceAll(token, 'l', '2')
);
CREATE OR REPLACE FUNCTION _caverphoneRemove2s AS (token) -> (
    replaceAll(token, '2', '')
);

CREATE OR REPLACE FUNCTION _caverphoneReplaceFinal3 AS (token) -> (
    replaceRegexpAll(token, '3$', 'A')
);

CREATE OR REPLACE FUNCTION _caverphoneRemove3s AS (token) -> (
    replaceAll(token, '3', '')
);

CREATE OR REPLACE FUNCTION _caverphoneAddTen1s AS (token) -> (
    concat(token, '1111111111')
);

CREATE OR REPLACE FUNCTION _caverphoneFirstTen AS (token) -> (
    substring(token, 1, 10)
);

CREATE OR REPLACE FUNCTION caverphone AS (s) -> (
    -- Combine the transformation functions here
    upper(
    _caverphoneFirstTen(
    _caverphoneAddTen1s(
    _caverphoneRemove3s(
    _caverphoneReplaceFinal3(
    _caverphoneRemove2s(
    _caverphoneReplaceL(
    _caverphoneReplaceFinalL(
    _caverphoneReplaceL3(
    _caverphoneReplaceR(
    _caverphoneReplaceFinalR(
    _caverphoneReplaceR3(
    _caverphoneReplaceH(
    _caverphoneReplaceInitialH(
    _caverphoneReplaceW(
    _caverphoneReplaceFinalW(
    _caverphoneReplaceWh3(
    _caverphoneReplaceW3(
    _caverphoneReplaceGroupsN(
    _caverphoneReplaceGroups(
    _caverphoneReplaceG(
    _caverphoneReplaceGh(
    _caverphoneReplace3gh3(
    _caverphoneReplaceY(
    _caverphoneReplaceInitialY(
    _caverphoneReplaceInitialY3(
    _caverphoneReplaceJ(
    _caverphoneReplaceVowels(
    _caverphoneReplaceInitialVowel(
    _caverphoneReplaceZ(
    _caverphoneReplaceSh(
    _caverphoneReplaceB(
    _caverphoneReplacePh(
    _caverphoneReplaceD(
    _caverphoneReplaceTioTia(
    _caverphoneReplaceDg(
    _caverphoneReplaceV(
    _caverphoneReplaceX(
    _caverphoneReplaceQ(
    _caverphoneReplaceC(
    _caverphoneReplaceTch(
    _caverphoneReplaceCiCeCy(
    _caverphoneReplaceCq(
    _caverphoneReplaceMb(
    _caverphoneReplaceGn(
    _caverphoneReplaceInitial(
    _caverphoneRemoveFinalE(
    _caverphoneRemoveNonAlpha(
    _caverphoneToLower(s)
    )))))))))))))))))))))))))))))))))))))))))))))))));
