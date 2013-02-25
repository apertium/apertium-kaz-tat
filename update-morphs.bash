#!/bin/bash

#assuming that you have the whole apertium tree in your source dir. and you are in kaz-tat directory

python3 ../../trunk/apertium-tools/trim-lexc.py apertium-kaz-tat.kaz-tat.dix ../../incubator/apertium-kaz/apertium-kaz.kaz.lexc ../../incubator/apertium-tat/apertium-tat.tat.lexc

cp /tmp/apertium-kaz.kaz.lexc.trimmed apertium-kaz-tat.kaz.lexc
cp /tmp/apertium-tat.tat.lexc.trimmed apertium-kaz-tat.tat.lexc

cp ../../incubator/apertium-kaz/apertium-kaz.kaz.twol apertium-kaz-tat.kaz.twol
cp ../../incubator/apertium-kaz/apertium-kaz.kaz.rlx apertium-kaz-tat.kaz-tat.rlx

cp ../../incubator/apertium-tat/apertium-tat.tat.twol apertium-kaz-tat.tat.twol
cp ../../incubator/apertium-tat/apertium-tat.tat.rlx apertium-kaz-tat.tat-kaz.rlx

exit 0


