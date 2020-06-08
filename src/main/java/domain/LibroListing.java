package domain;


import domain.g.LibroTable;
import org.jetbrains.annotations.NotNull;
import tekgenesis.common.collections.Seq;
import tekgenesis.form.Action;
import tekgenesis.form.FormTable;
import tekgenesis.persistence.Criteria;
import tekgenesis.persistence.Select;

/** User class for form: LibroListing */
public class LibroListing extends LibroListingBase
{


    @Override
    public void loadLibros() {
        final FormTable<LibrosRow> table = getLibros();
        Libro.forEach(currentLibro -> agregarFila(table, currentLibro));
    }

    public void agregarFila(FormTable<LibrosRow> table, Libro libro) {
        LibrosRow fila = table.add();
        fila.setLibroAutores(libro.getLibroAutor().mkString());
        fila.populate(libro);
    }

    @Override
    public void load() {
        setAutorOptions(Autor.listAll());
        setEditorialBusquedaOptions(Editorial.listAll());
    }


    @NotNull
    @Override
    public Action filtroLibro() {

        Criteria criteria = Criteria.EMPTY;
        if(isDefined(Field.TITULO_BUSQUEDA)){
            criteria = criteria.and(LibroTable.LIBRO.TITULO.contains(getTituloBusqueda()));
        }
        if(isDefined(Field.FECHA_DESDE)){
            criteria = criteria.and(LibroTable.LIBRO.FECHA_DE_PUBLICACION.ge(getFechaDesde()));
        }
        if(isDefined(Field.FECHA_HASTA)){
            criteria = criteria.and(LibroTable.LIBRO.FECHA_DE_PUBLICACION.le(getFechaHasta()));
        }
        if(isDefined(Field.AUTOR)){
            Seq<Integer> idsLibros = getAutor().getIdsLibros();
            criteria = criteria.and(LibroTable.LIBRO.ID.in(idsLibros));
        }
        if(isDefined(Field.EDITORIAL_BUSQUEDA)){
            criteria = criteria.and(LibroTable.LIBRO.EDITORIAL_ID.eq(getEditorialBusqueda().getId()));

        }

        Select<Libro> listaFiltrada = Libro.list().where(criteria);
        FormTable<LibrosRow> table = getLibros();
        table.clear();
        listaFiltrada.forEach(libro -> agregarFila(table,libro));
        return actions().getDefault();
    }




    //~ Inner Classes ............................................................................................................

    public class LibrosRow
        extends LibrosRowBase
    {

    }
}
