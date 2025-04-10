package sena.adso.sinfonica_nobsa.model;

public class WindInstrument extends Instrument{
    private String material; //wood, brass, silver
    private String mouthpieceType;

    public WindInstrument(int id, String name, String condition, String material, String mouthpieceType) {
        super(id, name, "Wind", condition);
        this.material = material;
        this.mouthpieceType = mouthpieceType;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public String getMouthpieceType() {
        return mouthpieceType;
    }

    public void setMouthpieceType(String mouthpieceType) {
        this.mouthpieceType = mouthpieceType;
    }

    @Override
    public String getDescription() {
        return getName() + " is a wind instrument made of " + material +
                " with a " + mouthpieceType + " mouthpiece.";
    }

    @Override
    public String toString() {
        return super.toString() + ", Material: " + material + 
                ", Mouthpiece Type: " + mouthpieceType;
    }
    
    
}
