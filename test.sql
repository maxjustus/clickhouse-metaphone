CREATE OR REPLACE FUNCTION Expect AS (result, input, expected, message) -> (
    SELECT if(expected != result,
        '!!! FAIL --- ' || message || ' --- given: "' || toString(input) || '" ' || 'expected: "' || toString(expected) || '" got: "' || toString(result) || '"',
        '    PASS --- ' || message || ' --- given: "' || toString(input) || '" ' || 'expected: "' || toString(expected))
);

-- Test cases for _metaphoneDropG
SELECT Expect(_metaphoneDropG('alight'), 'alight', 'aliht', '_metaphoneDropG: should drop G before H if not at the end or before vowel');
SELECT Expect(_metaphoneDropG('fright'), 'fright', 'friht', '_metaphoneDropG: should drop G before H if not at the end or before vowel');
SELECT Expect(_metaphoneDropG('aligned'), 'aligned', 'alined', '_metaphoneDropG: should drop G if followed by N or NED at the end');
SELECT Expect(_metaphoneDropG('align'), 'align', 'alin', '_metaphoneDropG: should drop G if followed by N or NED at the end');

-- Test cases for _metaphoneTransformG
SELECT Expect(_metaphoneTransformG('age'), 'age', 'aje', '_metaphoneTransformG: should transform G to J if followed by I, E or Y and not preceeded by G');
SELECT Expect(_metaphoneTransformG('gin'), 'gin', 'jin', '_metaphoneTransformG: should transform G to J if followed by I, E or Y and not preceeded by G');
SELECT Expect(_metaphoneTransformG('august'), 'august', 'aukust', '_metaphoneTransformG: should transform G to K');
SELECT Expect(_metaphoneTransformG('aggrade'), 'aggrade', 'akrade', '_metaphoneTransformG: should transform G to K');

-- Test cases for _metaphoneDropH
SELECT Expect(_metaphoneDropH('alriht'), 'alriht', 'alrit', '_metaphoneDropH: should drop H if after vowel and not before vowel');
SELECT Expect(_metaphoneDropH('that'), 'that', 'that', '_metaphoneDropH: should not drop H if after vowel');
SELECT Expect(_metaphoneDropH('chump'), 'chump', 'chump', '_metaphoneDropH: should not drop H if not before vowel');

-- Test cases for _metaphoneTransformCK
SELECT Expect(_metaphoneTransformCK('check'), 'check', 'chek', '_metaphoneTransformCK: should transform CK to K');

-- Test cases for _metaphoneTransformPH
SELECT Expect(_metaphoneTransformPH('phone'), 'phone', 'fone', '_metaphoneTransformPH: should transform PH to F');

-- Test cases for _metaphoneTransformQ
SELECT Expect(_metaphoneTransformQ('quack'), 'quack', 'kuack', '_metaphoneTransformQ: should transform Q to K');

-- Test cases for _metaphoneTransformS
SELECT Expect(_metaphoneTransformS('shack'), 'shack', 'xhack', '_metaphoneTransformS: should transform S to X if followed by H, IO, or IA');
SELECT Expect(_metaphoneTransformS('sialagogues'), 'sialagogues', 'xialagogues', '_metaphoneTransformS: should transform S to X if followed by H, IO, or IA');
SELECT Expect(_metaphoneTransformS('asia'), 'asia', 'axia', '_metaphoneTransformS: should transform S to X if followed by H, IO, or IA');
SELECT Expect(_metaphoneTransformS('substance'), 'substance', 'substance', '_metaphoneTransformS: should not transform S to X if not followed by H, IO, or IA');

-- Test cases for _metaphoneTransformT
SELECT Expect(_metaphoneTransformT('dementia'), 'dementia', 'demenxia', '_metaphoneTransformT: should transform T to X if followed by IA or IO');
SELECT Expect(_metaphoneTransformT('abbreviation'), 'abbreviation', 'abbreviaxion', '_metaphoneTransformT: should transform T to X if followed by IA or IO');
SELECT Expect(_metaphoneTransformT('that'), 'that', '0at', '_metaphoneTransformT: should transform TH to 0');

-- Test cases for _metaphoneDropT
SELECT Expect(_metaphoneDropT('backstitch'), 'backstitch', 'backstich', '_metaphoneDropT: should drop T if followed by CH');

-- Test cases for _metaphoneTransformV
SELECT Expect(_metaphoneTransformV('vestige'), 'vestige', 'festige', '_metaphoneTransformV: should transform V to F');

-- Test cases for _metaphoneDropW
SELECT Expect(_metaphoneDropW('bowl'), 'bowl', 'bol', '_metaphoneDropW: should drop W if not followed by vowel');
SELECT Expect(_metaphoneDropW('warsaw'), 'warsaw', 'warsa', '_metaphoneDropW: should drop W if not followed by vowel');

-- Test cases for _metaphoneTransformX
SELECT Expect(_metaphoneTransformX('xenophile'), 'xenophile', 'senophile', '_metaphoneTransformX: should transform X to S if at beginning');
SELECT Expect(_metaphoneTransformX('admixed'), 'admixed', 'admiksed', '_metaphoneTransformX: should transform X to KS if not at beginning');

-- Test cases for _metaphoneDropY
SELECT Expect(_metaphoneDropY('analyzer'), 'analyzer', 'analzer', '_metaphoneDropY: should drop Y if not followed by a vowel');
SELECT Expect(_metaphoneDropY('specify'), 'specify', 'specif', '_metaphoneDropY: should drop Y if not followed by a vowel');
SELECT Expect(_metaphoneDropY('allying'), 'allying', 'allying', '_metaphoneDropY: should not drop Y if followed by a vowel');

-- Test cases for _metaphoneTransformZ
SELECT Expect(_metaphoneTransformZ('blaze'), 'blaze', 'blase', '_metaphoneTransformZ: should transform Z to S');

-- Test cases for _metaphoneDedup
SELECT Expect(_metaphoneDedup('dropping'), 'dropping', 'droping', '_metaphoneDedup: should drop duplicate adjacent letters, except C');
SELECT Expect(_metaphoneDedup('accelerate'), 'accelerate', 'accelerate', '_metaphoneDedup: should not drop duplicate C');

-- Test cases for _metaphoneDropInitialLetters
SELECT Expect(_metaphoneDropInitialLetters('knuth'), 'knuth', 'nuth', '_metaphoneDropInitialLetters: should drop some initial letters');
SELECT Expect(_metaphoneDropInitialLetters('gnat'), 'gnat', 'nat', '_metaphoneDropInitialLetters: should drop some initial letters');
SELECT Expect(_metaphoneDropInitialLetters('aegis'), 'aegis', 'egis', '_metaphoneDropInitialLetters: should drop some initial letters');
SELECT Expect(_metaphoneDropInitialLetters('pneumatic'), 'pneumatic', 'neumatic', '_metaphoneDropInitialLetters: should drop some initial letters');
SELECT Expect(_metaphoneDropInitialLetters('wrack'), 'wrack', 'rack', '_metaphoneDropInitialLetters: should drop some initial letters');
SELECT Expect(_metaphoneDropInitialLetters('garbage'), 'garbage', 'garbage', '_metaphoneDropInitialLetters: should not drop other initial letters');

-- Test cases for _metaphoneDropBafterMAtEnd
SELECT Expect(_metaphoneDropBafterMAtEnd('dumb'), 'dumb', 'dum', '_metaphoneDropBafterMAtEnd: should drop B if words end with MB');
SELECT Expect(_metaphoneDropBafterMAtEnd('dumbo'), 'dumbo', 'dumbo', '_metaphoneDropBafterMAtEnd: should not drop B after M if not at end of word');

-- Test cases for _metaphoneCTransform
SELECT Expect(_metaphoneCTransform('change'), 'change', 'xhange', '_metaphoneCTransform: should replace CH to X');
SELECT Expect(_metaphoneCTransform('discharger'), 'discharger', 'diskharger', '_metaphoneCTransform: should not replace CH to X if part of SCH');
SELECT Expect(_metaphoneCTransform('aesthetician'), 'aesthetician', 'aesthetixian', '_metaphoneCTransform: should replace CIA to X');
SELECT Expect(_metaphoneCTransform('cieling'), 'cieling', 'sieling', '_metaphoneCTransform: C should become S if followed by I, E, or Y');
SELECT Expect(_metaphoneCTransform('cuss'), 'cuss', 'kuss', '_metaphoneCTransform: should transform other C''s to K');

-- Test cases for _metaphoneDTransform
SELECT Expect(_metaphoneDTransform('abridge'), 'abridge', 'abrijge', '_metaphoneDTransform: should transform D to J if followed by GE, GY, GI');
SELECT Expect(_metaphoneDTransform('bid'), 'bid', 'bit', '_metaphoneDTransform: should transform D to T if not followed by GE, GY, GI');

-- Test cases for metaphone
SELECT Expect(metaphone('phonetics'), 'phonetics', 'FNTKS', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('transition'), 'transition', 'TRNSXN', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('astronomical'), 'astronomical', 'ASTRNMKL', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('buzzard'), 'buzzard', 'BSRT', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('wonderer'), 'wonderer', 'WNTRR', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('district'), 'district', 'TSTRKT', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('hockey'), 'hockey', 'HK', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('capital'), 'capital', 'KPTL', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('penguin'), 'penguin', 'PNKN', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('garbonzo'), 'garbonzo', 'KRBNS', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('lightning'), 'lightning', 'LTNNK', 'metaphone: should return the correct metaphone encoding');
SELECT Expect(metaphone('light'), 'light', 'LT', 'metaphone: should return the correct metaphone encoding');

select Expect(symspellD1('phonetics'), 'phonetics',
    ['HONETICS','PONETICS','PHNETICS','PHOETICS','PHONTICS','PHONEICS','PHONETCS','PHONETIS','PHONETIC','PHONETICS'],
    'symspellD1: should return all delete distance 1 permutations');

select Expect(symspellD2('max'), 'max',
    ['AX', 'MX', 'MA','MAX','X', 'A', 'M'],
    'symspellD1: should return all delete distance 2 permutations');

-- Test cases for caverphone
SELECT Expect(caverphone('Peter'), 'Peter', 'PTA1111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Peady'), 'Peady', 'PTA1111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Jackson'), 'Jackson', 'YKSN111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Tremain'), 'Tremain', 'TRMN111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Smith'), 'Smith', 'SMT1111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Gough'), 'Gough', 'KA11111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Williams'), 'Williams', 'WLMS111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Brown'), 'Brown', 'PRN1111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Wilson'), 'Wilson', 'WSN1111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Lee'), 'Lee', 'LA11111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Thompson'), 'Thompson', 'TMPSN11111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Anderson'), 'Anderson', 'ANTSN11111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Catherine'), 'Catherine', 'KTRN111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Elizabeth'), 'Elizabeth', 'ALSPT11111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Margaret'), 'Margaret', 'MKRT111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Nathaniel'), 'Nathaniel', 'NTNA111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Stephanie'), 'Stephanie', 'STFNA11111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Zachary'), 'Zachary', 'SKRA111111', 'caverphone: should return the correct Caverphone encoding');

-- Additional test cases for caverphone
SELECT Expect(caverphone('add'), 'add', 'AT11111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('eat'), 'eat', 'AT11111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('hold'), 'hold', 'AT11111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('orange'), 'orange', 'ARNK111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('test'), 'test', 'TST1111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('ready'), 'ready', 'RTA1111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('апельсин'), 'апельсин', '1111111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('ብርቱካናማ'), 'ብርቱካናማ', '1111111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('کینو'), 'کینو', '1111111111', 'caverphone: should return the correct Caverphone encoding');

-- Additional provided Caverphone test cases
SELECT Expect(caverphone('mayer'), 'mayer', 'MA11111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('meier'), 'meier', 'MA11111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Henrichsen'), 'Henrichsen', 'ANRKSN1111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Henricsson'), 'Henricsson', 'ANRKSN1111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Henriksson'), 'Henriksson', 'ANRKSN1111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Hinrichsen'), 'Hinrichsen', 'ANRKSN1111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Stevenson'), 'Stevenson', 'STFNSN1111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Peter'), 'Peter', 'PTA1111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Karleen,'), 'Karleen,', 'KLN1111111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Thompson'), 'Thompson', 'TMPSN11111', 'caverphone: should return the correct Caverphone encoding');
SELECT Expect(caverphone('Whitlam'), 'Whitlam', 'WTLM111111', 'caverphone: should return the correct Caverphone encoding');
