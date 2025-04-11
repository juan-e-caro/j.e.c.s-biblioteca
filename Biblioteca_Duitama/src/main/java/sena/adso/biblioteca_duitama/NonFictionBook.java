package sena.adso.biblioteca_duitama;

public class NonFictionBook extends Book {
    private String theme;
    private String objectivePublic;

    public NonFictionBook(int id, String name, String type, String condition, String theme, String objectivePublic) {
        super(id, name, type, condition);
        this.theme = theme;
        this.objectivePublic = objectivePublic;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getObjectivePublic() {
        return objectivePublic;
    }

    public void setObjectivePublic(String objectivePublic) {
        this.objectivePublic = objectivePublic;
    }
    
    @Override
    public String getDescription(){
        return getName() + " el area tematica en este libro es " + theme +
                " teniendo como publico objetivo a los " + objectivePublic;
    }
    
    @Override
    public String toString() {
        return super.toString() + ", Área Tematica: " + theme +
                ", Publico Objetivo: " +objectivePublic;
    }
}
