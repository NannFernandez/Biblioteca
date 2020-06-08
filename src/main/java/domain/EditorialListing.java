package domain;


import org.jetbrains.annotations.NotNull;
import tekgenesis.common.collections.Seq;
import tekgenesis.form.Action;
import tekgenesis.form.FormTable;
import tekgenesis.persistence.InnerEntitySeq;

/** User class for form: EditorialListing */
public class EditorialListing extends EditorialListingBase
{

    public void loadEditorials() {
        this.filtroEditorial();
    }

    @NotNull
    @Override
    public Action filtroEditorial() {
        final FormTable<EditorialsRow> table = getEditorials();
        table.clear();
        Editorial.forEach(currentEditorial -> agregarFila(table, currentEditorial));
        return actions.getDefault();
    }

    private void agregarFila(FormTable<EditorialsRow> table, Editorial editorial) {

        Seq<InnerLibroAutor> autoresLibros = editorial.getEditorialLibro().flatMap(editorialLibro -> editorialLibro.getLibroAutor());

        Seq<InnerLibroAutor> autoresLibrosFiltrados = autoresLibros.filter(autorLibro-> cumpleFechaDePublicacion(autorLibro.getLibro()));

        Seq<Autor> autoresDeLaEditorial = autoresLibrosFiltrados.map(libroAutor -> libroAutor.getAutor()).toSet();

        int cantidadDeAutores = autoresDeLaEditorial.size();

        if(cantidadDeAutores >= 1) {
            EditorialsRow fila = table.add();
            fila.setCantidadDeAutores(cantidadDeAutores);
            fila.populate(editorial);
        }
    }

    public boolean cumpleFechaDePublicacion(Libro libro) {
        return cumpleFechaDesde(libro) && cumpleFechaHasta(libro);
    }

    private boolean cumpleFechaHasta(Libro libro) {
        if(isDefined(Field.FECHA_HASTA)){
            return libro.getFechaDePublicacion().isLessOrEqualTo(getFechaHasta());
        } else { return true;}
    }

    private boolean cumpleFechaDesde(Libro libro) {
        if(isDefined(Field.FECHA_DESDE)){
            return libro.getFechaDePublicacion().isGreaterOrEqualTo(getFechaDesde());
        } else { return true;}
    }


    //~ Inner Classes ............................................................................................................

    public class EditorialsRow
        extends EditorialsRowBase
    {

    }
}
