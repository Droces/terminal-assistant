# Project name, programming language and version
project (
    'com.github.droces.terminal-assistant',
    'vala', 'c',
    version: '0.0.1'
)

# Translation module
i18n = import ('i18n')

# Project arguments
add_project_arguments (
    '-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name ()),
    language: 'c'
)

# Listing dependencies
dependencies = [
    dependency ('glib-2.0'),
    dependency ('gtk+-3.0')
]

subdir ('src')

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable (
    meson.project_name (),
    sources,
    dependencies: dependencies,
    install: true
)

subdir ('data')
subdir ('po')

meson.add_install_script ('meson/post_install.py')

# Install the .desktop file so the Applications Menu will see it
install_data(
    join_paths('data', meson.project_name () + '.desktop.in'),
    install_dir: join_paths(get_option('datadir'), 'applications'),
    rename: meson.project_name() + '.desktop'
)

# Install the .appdata.xml file so AppCenter will see it
install_data(
    join_paths('data', meson.project_name () + '.appdata.xml.in'),
    install_dir: join_paths(get_option('datadir'), 'metainfo'),
    rename: meson.project_name() + '.appdata.xml'
)