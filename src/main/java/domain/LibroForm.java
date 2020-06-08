package domain;


import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;

/** User class for form: LibroForm */
public class LibroForm
    extends LibroFormBase
{
    @NotNull
    @Override
    public Action guardarLibro() {
        create();
        return actions.navigate(LibroListing.class).withMessage("Libro guardado!");
    }

    //~ Inner Classes ............................................................................................................

    public class LibroAutorRow
        extends LibroAutorRowBase
    {

    }
}
