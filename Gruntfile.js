module.exports = function(grunt) {
  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    watch: {
      html: {
        files: '**/*.html',
        options: {
          livereload: true
        }
      },
      css: {
        files: 'less/**/*.less',
        tasks: ['less'],
        options: {
          livereload: true
        }
      }
    },

    less: {
      development: {
        options: {},
        files: {
          "css/polymerbook.css": "less/style.less"
        }
      },
      production: {
        options: {
          paths: ["assets/css"],
          cleancss: true
        },
        files: {
          "css/polymerbook.css": "less/style.less"
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-watch');
};
