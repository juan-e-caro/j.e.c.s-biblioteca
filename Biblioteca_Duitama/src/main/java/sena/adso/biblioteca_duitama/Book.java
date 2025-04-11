package sena.adso.biblioteca_duitama;

public abstract class Book {
    private int id;
    private String name;
    private String type;
    private String condition;
    private boolean available;

    public Book(int id, String name, String type, String condition) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.condition = condition;
        this.available = true;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean avialiable) {
        this.available = available;
    }
    
    public abstract String getDescription();
    
    @Override
    public String toString(){
        return "ID: " + id + ", Name: " + name + ", Type: " + type +
                ", Condition: " + condition + ", Available " + (available ? "Yes" : "No");
    }
    
    
}
