package sena.adso.sinfonica_nobsa.model;

import java.util.ArrayList;
import java.util.Date;


public class InstrumentManager {
    private static InstrumentManager instance;
    private ArrayList<Instrument> instruments;
    private ArrayList<Loan> loans;
    private int nextInstrumentId;
    private int nextLoanId;

    public InstrumentManager() {
        instruments = new ArrayList<>();
        loans = new ArrayList<>();
        nextInstrumentId = 1;
        nextLoanId = 1;
        
        addSampleData();
    }
    
    //Patrón Singlentón
    public static synchronized InstrumentManager getInstance(){
        if (instance == null) {
            instance = new InstrumentManager();
        }
        return instance;
    }

    private void addSampleData() {
        //Add some string instruments
        addInstrument(new StringInstrument(nextInstrumentId++, "Violin", "Good", 4, "Steel"));
        addInstrument(new StringInstrument(nextInstrumentId++, "Guitar", "Excellent", 6, "nylon"));
        addInstrument(new StringInstrument(nextInstrumentId++, "Cello", "Fair", 4, "Steel"));
        
        addInstrument(new WindInstrument(nextInstrumentId++, "Flute", "Excellent", "Silver", ""));
        addInstrument(new WindInstrument(nextInstrumentId++, "Clarinet", "Good", "Wood", "Reed"));
        
        addInstrument(new PercussionInstrument(nextInstrumentId++, "Drum Set", "Good", "Wood and Metal", true));
        addInstrument(new PercussionInstrument(nextInstrumentId++, "Maracas", "Fair", "Wood", false));
        
    }
    
    public ArrayList<Instrument> getAllInstruments(){
        return instruments;
    }
    
    public ArrayList<Instrument> getAvailableInstruments(){
        ArrayList<Instrument> availableInstruments = new ArrayList<>();
        for (Instrument instrument : instruments) {
            if (instrument.isAvailable()) {
                availableInstruments.add(instrument);
            }
        }
        return availableInstruments;
    }
    
    
    public Instrument getInstrumentById(int id) {
        for (Instrument instrument : instruments) {
            if (instrument.getId() == id) {
                return instrument;
            }
        }
        return null;
    }

    public void addInstrument(Instrument instrument) {
        instruments.add(instrument);
    }
    
    public boolean updateInstrument(Instrument updateInstrument) {
        for (int i = 0; i < instruments.size(); i++) {
            if (instruments.get(i).getId() == updateInstrument.getId()) {
                instruments.set(i, updateInstrument);
                return true;
            }
        }
        return false;
    }
            
    public boolean deleteInstrument(int id) {
        for (Loan loan : loans) {
            if (loan.getInstrument().getId() == id && loan.isActive()) {
                return false;
            }
        }
        
        for (int i = 0; i < instruments.size(); i++) {
            if (instruments.get(i).getId() == id) {
                instruments.remove(i);
                return true;
            }
        }
        return false;
    }
    
    public ArrayList<Loan> getAllLoans() {
        return loans;
    }
    
    public ArrayList<Loan> getActiveLoans() {
        ArrayList<Loan> activeLoans = new ArrayList<>();
        for (Loan loan : loans) {
            if (loan.isActive()) {
                activeLoans.add(loan);
            }
        }
        return activeLoans;
    }
    
    public Loan getLoanById(int id) {
        for (Loan loan : loans) {
            if (loan.getId() == id) {
                return loan;
            }
        }
        return null;
    }
    
    public Loan createLoan(int instrumentId, String borrowerName, String borrowedId, int loanDays){
        Instrument instrument = getInstrumentById(instrumentId);
        
        if (instrument == null || !instrument.isAvailable()) {
            return null;
        }
        
        Date loanDate = new Date();
              
        Date dueDate = new Date(loanDate.getTime() + (loanDays * 24 * 60 * 60 * 1000L));
        
        Loan loan = new Loan(nextLoanId++, instrument, borrowerName, borrowedId, loanDate, dueDate);
        loans.add(loan);
        return loan;
    }
    
    public boolean returnInstrument(int loanId) {
        Loan loan = getLoanById(loanId);
        
        if (loan == null || !loan.isActive()) {
            return false;
        }
        
        loan.returnInstrument(new Date());
        return true;
    }
    
    public int getNextInstrumentId() {
        return nextInstrumentId;
    }
}
