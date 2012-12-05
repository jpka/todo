<?php

return CMap::mergeArray(
	require(dirname(__FILE__).'/main.php'),
	array(
		'components'=>array(
			'fixture'=>array(
				'class'=>'system.test.CDbFixtureManager',
			),
			'mongodb' => array(
        'class'             => 'EMongoDB',
        'connectionString'  => 'mongodb://localhost',
        'dbName'            => 'todo-tests',
        'fsyncFlag'         => false,
        'safeFlag'          => false,
        'useCursor'         => false,
      )
		)
	)
);
