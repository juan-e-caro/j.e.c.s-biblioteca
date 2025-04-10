package sena.adso.sinfonica_nobsa.model;

public class StringInstrument extends Instrument{
    private int numberOfStrings;
    private String stringType; //nylon, steel, gut

    public StringInstrument(int id, String name, String condition, int numberOfStrings, String stringType) {
        super(id, name, "String", condition);
        this.numberOfStrings = numberOfStrings;
        this.stringType = stringType;
    }

    public int getNumberOfStrings() {
        return numberOfStrings;
    }

    public void setNumberOfStrings(int numberOfStrings) {
        this.numberOfStrings = numberOfStrings;
    }

    public String getStringType() {
        return stringType;
    }

    public void setStringType(String stringType) {
        this.stringType = stringType;
    }

    @Override
    public String getDescription() {
        return getName() + " is a string instrument with " + numberOfStrings +
                " " + stringType + " strings.";
    }

    @Override
    public String toString() {
        return super.toString() + ", Number of Strings: " + numberOfStrings + 
                ", String Type: " + stringType;
    }
    
    
}
