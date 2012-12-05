module.exports = function( grunt ) {
  'use strict';
  //
  // Grunt configuration:
  //
  // https://github.com/cowboy/grunt/blob/master/docs/getting_started.md
  //
  grunt.initConfig({

    // Project configuration
    // ---------------------

    // specify an alternate install location for Bower
    bower: {
      dir: 'app/components'
    },

    // Coffee to JS compilation
    coffee: {
      php: {
        files: {
          'php/app/scripts/*.js': 'frontend/app/scripts/**/*.coffee' 
        }//,
        // options: {
        //   basePath: 'frontend/app/scripts'
        // }
      }//,
      // test: {
      //   files: {
      //     'test/specs.js': 'test/spec/**/*.coffee',
      //     'test/config.js': 'app/scripts/config.coffee'
      //   }
      // }
    },

    // compile .scss/.sass to .css using Compass
    compass: {
      php: {
        src: 'frontend/app/styles',
        dest: 'php/app/styles',
        images: 'frontend/app/images'
      }
    },

    copy: {
      php: {
        files: {
          'php/app/components/': 'frontend/app/components/**',
          'php/app/scripts/vendor/bootstrap/': 'frontend/app/scripts/vendor/bootstrap/**',
          'php/app/scripts/vendor/': 'frontend/app/scripts/vendor/**',
          'php/index.html': 'frontend/app/index.html'
        }
      }
    },

    clean: {
      php: ['php/app']
    },

    watch: {
      frontend: {
        files: ['frontend/app/**/*'],
        tasks: 'build:frontend'
      }
    }

  });

  grunt.registerTask('build:frontend', 'clean coffee compass copy');
  grunt.registerTask('auto:frontend', 'build:frontend watch:frontend');

  grunt.loadNpmTasks('grunt-contrib');
  grunt.loadNpmTasks('grunt-compass');
}