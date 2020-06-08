package domain;


import domain.g.AutorTable;
import domain.g.InnerLibroAutorTable;
import domain.g.LibroTable;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;
import tekgenesis.form.FormTable;
import tekgenesis.persistence.Criteria;
import tekgenesis.persistence.Select;

import java.util.Comparator;

/** User class for form: AutorListing */
public class AutorListing extends AutorListingBase
{
    @Override
    public void loadAutors() {
        filtroAutor();
    }

    public Action filtroAutor() {
        FormTable<AutorsRow> table = getAutors();
        table.clear();
        Autor.forEach(currentAutor -> agregarFilaFiltro(table, currentAutor));
        // table.sort();
        return actions.getDefault();
    }

    private void agregarFilaFiltro(FormTable<AutorsRow> table, Autor autor) {
        int cantidadDeLibros = autor.getAutorLibro().filter(autorLibro-> cumpleFechaDePublicacion(autorLibro.getLibro())).size();

        if(cantidadDeLibros >= 1) {
            AutorsRow fila = table.add();
            fila.setCantidadLibros(cantidadDeLibros);
            fila.populate(autor);
        }
    }

    public boolean cumpleFechaDePublicacion(Libro libro){
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

    public class AutorsRow extends AutorsRowBase {
    }
}
