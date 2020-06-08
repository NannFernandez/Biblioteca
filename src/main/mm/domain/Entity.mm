package domain;

entity Autor
    described_by nombre,apellido
    searchable
    {
    nombre      "Nombre"     :String;
    apellido    "Apellido"   :String;
    autorLibro  "Libro"      :InnerLibroAutor*;
    }


entity Editorial
    described_by nombre
    searchable
    {
    nombre         "Nombre"    :String;
    direccion      "Direccion" :String;
    Ciudad         "Ciudad"    :String;
    Pais           "Pais"      :String;
    editorialLibro "Libro"     :Libro*;
    }



entity Libro
    described_by titulo
    searchable
    {
    titulo              "Titulo"               :String;
    código              "Código"               :String;
    fechaDePublicacion  "Fecha De Publicacion" :Date;
    libroAutor          "Autor"                :entity InnerLibroAutor* described_by autor{
                                                autor "Autor" :Autor;
                                                };
    editorial           "Editorial"            :Editorial;
   }



