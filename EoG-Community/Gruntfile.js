module.exports = function (grunt) {

  const sass = require('node-sass'),
  cssnano = require('cssnano');

  grunt.initConfig({
    sass: {
      options: {
        implementation: sass,
        sourceMap: true
      },
      build: {
        options: {
          outputStyle: 'expanded'
        },
        files: {
          'src/css/raw/styles.css': 'src/sass/main.scss'
        }
      }
    },
    postcss: {
      autoprefix: {
        options: {
          processors: [
            require('autoprefixer')()
          ],
          map: {
            inline: false,
            annotation: 'src/css/raw/'
          }
        },
        files: {
          'src/css/raw/styles.css': 'src/css/raw/styles.css'
        }
      },
      compressed: {
        options: {
          processors: [
            cssnano()
          ],
          map: {
            inline: false,
            annotation: 'src/css/'
          }
        },
        files: {
          'public/css/styles.min.css': 'src/css/raw/styles.css'
        }
      }
    },
    browserify: {
      options: {
        transform: [['babelify', { presets: ['@babel/env'], compact: true }]]
      },
      build: {
        files: {
          'src/js/bundle/app.bundle.js': 'src/js/app.js'
        }
      }
    },
    uglify: {
      build: {
        files: {
          'public/js/app.bundle.min.js': 'src/js/bundle/app.bundle.js'
        }
      }
    },
    concat: {
      build: {
        files: {
          'public/js/app.bundle.min.js': [
            'src/js/third-party/accordion.min.js',
            'src/js/third-party/dropdown.min.js',
            'src/js/third-party/hexagon.min.js',
            'src/js/third-party/popup.min.js',
            'src/js/third-party/progressBar.min.js',
            'src/js/third-party/tab.min.js',
            'src/js/third-party/tooltip.min.js',
            'src/js/third-party/jquery-3.6.0.min.js',
            'public/js/app.bundle.min.js'
          ]
        }
      }
    }
  });

  // Load tasks
  grunt.loadNpmTasks('grunt-postcss');
  grunt.loadNpmTasks('grunt-sass');
  grunt.loadNpmTasks('grunt-browserify');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-concat');

  // Register global tasks
  grunt.registerTask('default', ['styles', 'scripts']);

  // Register custom tasks
  grunt.registerTask('styles', ['sass:build', 'postcss:autoprefix', 'postcss:compressed']);
  grunt.registerTask('scripts', ['browserify:build', 'uglify:build', 'concat:build']);
};