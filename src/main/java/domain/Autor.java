package domain;

import domain.g.AutorBase;
import tekgenesis.common.collections.Seq;

/** User class for Model: Autor */
public class Autor
    extends AutorBase
{
    public Seq<Integer> getIdsLibros()
    {
        return getAutorLibro().map(libroAutor -> libroAutor.getLibroId());

    }

}
