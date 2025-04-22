module.exports = {
    darkMode: "class",
    content: [
      "./public/*.html",
      "./app/**/*.html.erb",
      "./packs/**/*.html.erb",
      "./app/helpers/**/*.rb",
      "./app/components/**/*.{rb,css,html.erb}",
      "./app/assets/stylesheets/**/*.css",
      "./app/javascript/**/*.{js,ts,tsx}",
      "./node_modules/flowbite/**/*.js",
    ],
    plugins: [require("flowbite/plugin")],
    theme: {
      extend: {
        fontFamily: {
          "inter": ["Inter", "sans-serif"],
        },
        colors: {
          green: {
            "400": "#31C48D",
          },
        },
        transitionProperty: {
          "width": "width",
          "margin-left": "margin-left",
        },
        boxShadow: {
          "full": "0 0 0 100vmax rgba(0, 0, 0, .5)",
        },
      },
    },
  }
  