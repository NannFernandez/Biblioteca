package domain;


form AutorForm "Autor Form"
    : Autor
{
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"       : id, internal, optional;
    "Nombre"   : nombre;
    "Apellido" : apellido;
    /*"Libro"    : autorLibro, table;
    horizontal, style "margin-top-20" {
        button(add_row, autorLibro), style "margin-right-5";
        button(remove_row, autorLibro);
    };*/
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}


form EditorialForm "Editorial Form"
    : Editorial
{
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"        : id, internal, optional;
    "Nombre"    : nombre;
    "Direccion" : direccion;
    "Ciudad"    : Ciudad;
    "Pais"      : Pais;
    footer {
        button(save);
        button(cancel);
        button(delete), style "pull-right";
    };
}


form LibroForm "Libro Form"
    : Libro
{
    header {
        message(entity), col 8;
        search_box, col 4, style "pull-right";
    };
    "Id"                   : id, internal, optional;
    "Titulo"               : titulo;
    "Código"               : código;
    "Fecha De Publicacion" : fechaDePublicacion;
    "Autor"                : libroAutor, table {
        "Autor" : autor;
    };
    horizontal, style "margin-top-20" {
        button(add_row, libroAutor), style "margin-right-5";
        button(remove_row, libroAutor);
    };
    "Editorial"            : editorial;
    footer {
        guardarLibro: button(validate), on_click guardarLibro;
        button(cancel);
        button(delete), style "pull-right";
    };
}


form LibroListing "Libro Listing"

{
    header {
        message(title), col 12;
    };
    libros    : Libro, table, on_change saveLibro, on_load loadLibros, sortable {
        "Id"                   : id, internal, optional;
        "Titulo"               : titulo, display;
        "Código"               : código, display;
        "Fecha De Publicacion" : fechaDePublicacion,display;
        //"Autor"                : libroAutor, table;
         libroAutores "Autores": String, display;
        "Editorial"            : editorial, display;
    };
    horizontal, style "margin-top-20" {
        tituloBusqueda "Título": String, optional;
        fechaDesde     "Desde" : Date, optional ;
        fechaHasta    "Hasta" : Date, optional ;
    };
    horizontal, style "margin-top-20" {
        autor                 "Autor" : Autor,combo_box,optional ;
        editorialBusqueda     "Editorial" :Editorial, combo_box, optional ;
    };
     horizontal, style "margin-top-20" {
        buscar "Buscar" :  button, on_click filtroLibro;
        exportar "Exportar" :  button(export), icon file_excel_o, content_style "btn-info";
    };

    /*horizontal, style "margin-top-20" {
        button(add_row, libros), disable when forbidden(create), style "margin-right-5";
        button(remove_row, libros), disable when forbidden(delete), on_click removeLibro;
    };*/
}


form AutorListing "Ranking Autores"

{
    header {
        message(title), col 12;
    };
    autors    : Autor, table, on_change saveAutor, on_load loadAutors, sortable {
                   "Id"       : id, internal, optional;
                   "Nombre"   : nombre, display;
                   "Apellido" : apellido, display;
       // "Libro"    : autorLibro, table;
    cantidadLibros "Cantidad De Libros" :Int, display;
    };
    horizontal, style "margin-top-" {
    fechaDesde     "Desde" : Date, optional ;
    fechaHasta     "Hasta" : Date, optional ;
    };

    horizontal, style "margin-top-20" {
        buscar "Buscar" :  button, on_click filtroAutor;
        exportar "Exportar" :  button(export), icon file_excel_o, content_style "btn-info";
    };
   /* horizontal, style "margin-top-20" {
        button(add_row, autors), disable when forbidden(create), style "margin-right-5";
        button(remove_row, autors), disable when forbidden(delete), on_click removeAutor;
    };*/
}


form EditorialListing "Editorial Listing"
{
    header {
        message(title), col 12;
    };
    editorials    : Editorial, table, on_change saveEditorial, on_load loadEditorials, sortable {
        "Id"        : id, internal, optional;
                          "Nombre"    : nombre, display;
        cantidadDeAutores "Cantidad de Autores" :Int,display;
        //"Libro"     : editorialLibro, table;
    };
    horizontal, style "margin-top-" {
    fechaDesde     "Desde" : Date, optional ;
    fechaHasta     "Hasta" : Date, optional ;
    };

    horizontal, style "margin-top-20" {
        buscar "Buscar" :  button, on_click filtroEditorial;
        exportar "Exportar" :  button(export), icon file_excel_o, content_style "btn-info";
    };
    /*horizontal, style "margin-top-20" {

       button(add_row, editorials), disable when forbidden(create), style "margin-right-5";
       button(remove_row, editorials), disable when forbidden(delete), on_click removeEditorial;
    };*/
}





