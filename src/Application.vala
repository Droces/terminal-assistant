/*
* Copyright (c) 2020 - Today Dane Rossenrode (https://touchdreams.co.za)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Dane Rossenrode <droces@gmail.com>
*/

public class Application : Gtk.Application {

    public Application () {
        Object (
            application_id: "com.github.droces.terminal-assistant",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = "Terminal Assistant"
        };
        main_window.show_all ();

        var builder = new Gtk.Builder.from_file ("window.ui");
        var window = builder.get_object ("window") as Gtk.ApplicationWindow;

        var main_text = builder.get_object ("main-text") as Gtk.TextView;
        main_text.buffer.set_text (get_json());

        window.show_all ();
    }

    public static int main (string[] args) {
        var app = new Application ();
        return app.run (args);
    }

    protected string get_json () {
        var file_contents = "";
        File file = File.new_for_path ("basic_info_commands.json");

        if (! file.query_exists ()) {
            stderr.printf ("File '%s' doesn't exist.\n", file.get_path ());
            return file_contents;
        }
        try {
            // Open file for reading and wrap returned FileInputStream into a
            // DataInputStream, so we can read line by line
            var dis = new DataInputStream (file.read ());
            string line;
            // Read lines until end of file (null) is reached
            while ((line = dis.read_line (null)) != null) {
                file_contents += line;
            }
        }
        catch (Error e) {
            stderr.printf ("%s\n", e.message);
        }

        // var parser = new Json.Parser ();
        // parser.load_from_data (file_contents);
        // var root_object = parser.get_root ().get_object ();
        try {
            var json = Json.from_string (file_contents);
            // stdout.printf(json.get_string());
            var root_object = json.get_object ();
            var commands = root_object.get_object_member ("commands");
            stdout.printf((string) commands.get_size ());
        }
        catch (Error e) {
            stderr.printf ("%s\n", e.message);
        }

        return file_contents;
    }
}

