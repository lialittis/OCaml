(*type <record-name> =
    { <field> : <type>;
      <field> : <type>;
      ...
    }*)

(*Note that record field names must start with a lowercase letter.*)

open Core

type service_info =
  { service_name : string ;
    port : int ;
    protocol : string;
  }

(*https://dev.realworldocaml.org/records.html*)
