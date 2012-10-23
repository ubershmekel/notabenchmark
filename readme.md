Not a benchmark for mobile game engines
=================

This is a toy that puts an exponentially increasing amount of sprites just
jittering about with the aim to see when the game engine dies. Why is it not
a benchmark? Well, because a better benchmark would have a more varied
test set. Also, you should really compare the tools and documentation as
they can make or break the value you get from an engine or framework.

Tested on Windows 7
-----------------
Number of Sprites, fps

MOAI Results:

    1       59.840425531915 fps
    2       59.52380952381 fps
    4       60.646900269542 fps
    8       59.960026648901 fps
    16      59.800664451827 fps
    32      60.120240480962 fps
    64      59.960026648901 fps
    128     59.960026648901 fps
    256     60.160427807487 fps
    512     59.800664451827 fps
    1024    60.120240480962 fps
    2048    59.960026648901 fps
    4096    60.281312793034 fps
    8192    49.234135667396 fps
    16384   20.988805970149 fps
    32768   8.2576383154418 fps

Corona Results:

    1       32.94289897511 fps
    2       32.420749279538 fps
    4       32.526201662452 fps
    8       32.83473184969 fps
    16      32.739177882869 fps
    32      32.644178454844 fps
    64      32.455824017311 fps
    128     32.846715328467 fps
    256     32.620514679231 fps
    512     33.039647577093 fps
    1024    32.763014197305 fps
    2048    32.906764168189 fps
    4096    33.161385408988 fps
    8192    18.274111675127 fps
    16384   9.8651759289707 fps


