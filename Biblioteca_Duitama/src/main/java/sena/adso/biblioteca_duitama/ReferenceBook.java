package sena.adso.biblioteca_duitama;

public class ReferenceBook extends Book {
    private String academicArea;
    private boolean borrowed;

    public ReferenceBook(int id, String name, String type, String condition, String academicArea, boolean borrowed) {
        super(id, name, type, condition);
        this.academicArea = academicArea;
        this.borrowed = borrowed;
    }

    public String getAcademicArea() {
        return academicArea;
    }

    public void setAcademicArea(String academicArea) {
        this.academicArea = academicArea;
    }

    public boolean isBorrowed() {
        return borrowed;
    }

    public void setBorrowed(boolean borrowed) {
        this.borrowed = borrowed;
    }
    
    @Override
    public String getDescription(){
        return getName() + " la referencia de este libro pertenece al campo academico de " + academicArea +
                " y " + (borrowed ? " se puede prestar al publico" : "solo se permite usar en la biblioteca");
    }
    
    @Override
    public String toString() {
        return super.toString() + ", Campo Academico: " + academicArea +
                ", puede ser prestado?: " + (borrowed ? "Si" : "No");
    }
}
