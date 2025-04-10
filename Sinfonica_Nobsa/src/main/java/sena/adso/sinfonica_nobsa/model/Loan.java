package sena.adso.sinfonica_nobsa.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Loan {
    private int id;
    private Instrument instrument;
    private String borrowerName;
    private String borrowerId;
    private Date loanDate;
    private Date dueDate;
    private Date returnDate;

    public Loan(int id, Instrument instrument, String borrowerName, String borrowerId, Date loanDate, Date dueDate) {
        this.id = id;
        this.instrument = instrument;
        this.borrowerName = borrowerName;
        this.borrowerId = borrowerId;
        this.loanDate = loanDate;
        this.dueDate = dueDate;
        this.returnDate = null;
        
        instrument.setAvailable(false);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Instrument getInstrument() {
        return instrument;
    }

    public void setInstrument(Instrument instrument) {
        this.instrument = instrument;
    }

    public String getBorrowerName() {
        return borrowerName;
    }

    public void setBorrowerName(String borrowerName) {
        this.borrowerName = borrowerName;
    }

    public String getBorrowerId() {
        return borrowerId;
    }

    public void setBorrowerId(String borrowerId) {
        this.borrowerId = borrowerId;
    }

    public Date getLoanDate() {
        return loanDate;
    }

    public void setLoanDate(Date loanDate) {
        this.loanDate = loanDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }
    
    public void returnInstrument(Date returnDate){
        this.returnDate = returnDate;
        this.instrument.setAvailable(true);
    }
    
    public boolean isActive(){
        return returnDate == null;
    }
    
    public boolean isOverdue(){
        if (!isActive()) {
            return false;
        }
        
        Date today = new Date();
        return today.after(dueDate);
    }

    @Override
    public String toString() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return " Loan ID: " +  id +
                "\nInstrument: " + instrument.getName() +
                "\nBorrower " + borrowerName + " (" + borrowerId + ")" + 
                "\nLoan Date: " + dateFormat.format(loanDate) + 
                "\nDue Date: " + dateFormat.format(dueDate) +
                "\nReturn Date: " + (returnDate != null ? dateFormat.format(returnDate) : "Not returned") +
                "\nStatus: " + (isActive() ? (isOverdue() ? "Overdue" : "Active") : "Returned");        
    }   
}
