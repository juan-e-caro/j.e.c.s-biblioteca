package sena.adso.sinfonica_nobsa.model;


public class PercussionInstrument extends Instrument{
    private String material; //wood, metal, synthetic
    private boolean tunable;

    public PercussionInstrument(int id, String name, String condition, String material, boolean tunable) {
        super(id, name, "Percussion", condition);
        this.material = material;
        this.tunable = tunable;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public boolean isTunable() {
        return tunable;
    }

    public void setTunable(boolean tunable) {
        this.tunable = tunable;
    }

    @Override
    public String getDescription() {
        return getName() + " is a percussion instrument made of " + material + 
                (tunable ? " and can be tuned." : " and cannot be tuned.");
    }

    @Override
    public String toString() {
        return super.toString() + ", Material: " + material + 
                ", Tunable: " + (tunable ? "Yes" : "No");
    }   
}
