package sena.adso.biblioteca_duitama;

import java.util.ArrayList;
import java.util.Date;

public class BookManager {
    private static BookManager instance;
    private ArrayList<Book> books;
    private ArrayList<LoanBook> loans;
    private int nextBookId;
    private int nextLoanId;
    
    public BookManager() {
        books = new ArrayList<>();
        loans = new ArrayList<>();
        nextBookId = 1;
        nextLoanId = 1;
        
    }
    
    public static synchronized BookManager getInstance(){
        if (instance == null) {
            instance = new BookManager();
        }
        return instance;
    }
    
    public ArrayList<Book> getAllBooks(){
        return books;
    }
    
    public ArrayList<Book> getAvailableBooks(){
        ArrayList<Book> availableBooks = new ArrayList<>();
        for (Book book : books){
            if (book.isAvailable()) {
                availableBooks.add(book);
            }
        }
        return availableBooks;
    }
    
    public Book getBookById(int id){
        for (Book book : books) {
            if (book.getId() == id) {
                return book;
            }
        }
        return null;
    }
    
    public void addBook(Book book){
        books.add(book);
    }
    
    public boolean updateBook(Book updateBook){
        for (int i = 0; i < books.size(); i++) {
            if (books.get(i).getId()== updateBook.getId()) {
                books.set(i, updateBook);
            }
        }
        return false;
    }
    
    public boolean deleteBook(int id){
        for (LoanBook loan : loans) {
            if (loan.getBook().getId() == id && loan.isActive()) {
                return false;
            }
        }
        
        for (int i = 0; i < books.size(); i++) {
            if (books.get(i).getId() == id) {
                books.remove(i);
                return true;
            }
        }
        return false;
    }
    
    public ArrayList<LoanBook> getAllLoans(){
        return loans;
    }
    
    public ArrayList<LoanBook> getActiveLoans(){
        ArrayList<LoanBook> activeLoans = new ArrayList<>();
        for (LoanBook loan : loans) {
            if (loan.isActive()) {
                activeLoans.add(loan);
            }
        }
        return activeLoans;
    }
    
    public LoanBook getLoanById(int id){
        for (LoanBook loan : loans) {
            if (loan.getId() == id) {
                return loan;
            }
        }
        return null;
    }
    
    public LoanBook createLoan(int BookId, String borrowerName, String borrowedId, int loanDays){
        Book book = getBookById(BookId);
        
        if (book == null || !book.isAvailable()) {
            return null;
        }
        
        Date loanDate = new Date();
        
        Date dueDate = new Date(loanDate.getTime() + (loanDays*24*60*60*1000L));

        
        LoanBook loan = new LoanBook(nextLoanId++, book, borrowerName, borrowedId, loanDate, dueDate);
        loans.add(loan);
        return loan;
    }
    
    public boolean returnBook (int loanId){
        LoanBook loan = getLoanById(loanId);
        
        if (loan == null || !loan.isActive()) {
            return false;
        }
   
        loan.returnBook(new Date());
        return true;
    }
    
    public int getNextBookid(){
        return nextBookId;
    }
}
