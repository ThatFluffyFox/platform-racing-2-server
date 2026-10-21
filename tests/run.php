<?php

// Aggregate test runner. Includes every *Test.php file in this directory and
// prints a single summary. Run with:
//   tests/run.sh

require_once __DIR__ . '/bootstrap.php';

foreach (glob(__DIR__ . '/*Test.php') as $file) {
    require_once $file;
}

exit(\pr2\tests\Test::summary());
