package sena.adso.biblioteca_duitama;

public class FictionBook extends Book {
    private String gender;
    private String autor;
    private boolean literaryAwards;

    public FictionBook(int id, String name, String type, String condition, String gender, String autor, boolean literaryAwards) {
        super(id, name, "Ficción", condition);
        this.gender = gender;
        this.autor = autor;
        this.literaryAwards = literaryAwards;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public boolean isLiteraryAwards() {
        return literaryAwards;
    }

    public void setLiteraryAwards(boolean literaryAwards) {
        this.literaryAwards = literaryAwards;
    }

    @Override
    public String getDescription(){
        return getName() + " es un libro de ficcion del genero " + gender +
                ", perteneciente al autor " + autor + 
                (literaryAwards ? ", con conocidos premios literarios" : ", sin conocidos premios literarios");
    }

    @Override
    public String toString(){
        return super.toString() + ", Genero: " + gender + ", Autor: " + autor +
                ", Literary Awards: " + (literaryAwards ? "Si" : "No");
    }
    
    
    
}
